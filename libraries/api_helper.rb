module GrafanaCookbook
  module ApiHelper
    class BackendError < StandardError
    end

    # Login to Grafana to obtain a authenticated session id.
    # curl -D- -d '{"User":"admin","email":"","Password":"admin"}' -H "Content-Type: application/json;charset=utf-8" http://localhost:3000/login
    # Params:
    # +host+:: The host grafana is running on
    # +port+:: The port grafana is running on
    # +user+:: A grafana user with admin privileges
    # +password+:: The grafana user's password
    def login(host, port, user, password)
      http = Net::HTTP.new(host, port)
      request = Net::HTTP::Post.new('/login')
      request.add_field('Content-Type', 'application/json;charset=utf-8')
      request.body = { 'User' => user, 'email' => '', 'Password' => password }.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'Login was successful.',
        unauthorized: 'Invalid username/password.',
        unknown_code: 'DataSourceAPI::login unchecked response code: %{code}'
      )

      # sorry for the fancy hackery - rubists are welcome to make this better
      response['set-cookie'][/grafana_sess=(\w+);/, 1]
    rescue BackendError
      nil
    end

    # Retry limited number of time a block catching only specific exceptions
    # opts:
    #   :tries - Integer - number of time to retry the block (required)
    #   :wait_time - Integer - time to wait before next retry in seconds (default: 2s)
    #   :exceptions - Exception or Array of Exception - exceptions to catch (required)
    def with_limited_retry(opts)
      tries = opts.fetch :tries
      wait_time = opts.fetch :wait_time, 2
      exceptions = Array(opts.fetch(:exceptions))

      return if tries == 0

      begin
        yield
      rescue *exceptions
        if (tries -= 1) > 0
          sleep wait_time
          retry
        end
      end
    end

    # Generic method to build, perform and handle response of any API requests
    # Params:
    # +grafana_options+:: A hash of the host, port, user, and password as well as request parameters
    def do_request(grafana_options, payload = nil)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = case grafana_options[:method]
                when 'Post'
                  Net::HTTP::Post.new(grafana_options[:endpoint])
                when 'Put'
                  Net::HTTP::Put.new(grafana_options[:endpoint])
                when 'Delete'
                  Net::HTTP::Delete.new(grafana_options[:endpoint])
                else
                  Net::HTTP::Get.new(grafana_options[:endpoint])
                end
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.add_field('Accept', 'application/json')
      request.body = payload if payload

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: grafana_options[:success_msg],
        unknown_code: grafana_options[:unknown_code_msg]
      )
      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        nil
      end
    rescue BackendError
      nil
    end

    # Log the right thing when
    # Params:
    # +request+:: Net::HTTPRequest
    # +response+:: Net::HTTPResponse -
    # +messages+:: String or  -
    def handle_response(request, response, messages)
      case response
      when Net::HTTPSuccess
        handle_response_success request, messages[:success]
      when Net::HTTPUnauthorized
        handle_response_unauthorized messages[:unauthorized]
      when Net::HTTPNotFound
        handle_response_not_found request, messages[:not_found]
      when nil
        handle_response_conn_refused
      else
        handle_response_unknown request, response.code, messages[:unknown_code]
      end
    end

    # Format a request for use in error/debug message
    # Params:
    # +request+:: Net::HTTPRequest
    def request_message(request)
      "#{request.method} #{request.path}"
    end

    def handle_response_success(request, message)
      if message
        Chef::Log.debug message
      else
        Chef::Log.debug "Request succeeded when sending #{request_message request}"
      end
    end

    def handle_response_unauthorized(message)
      if message
        Chef::Log.error message
      else
        Chef::Log.error 'Invalid grafana_user and grafana_sess.'
      end
      raise BackendError
    end

    def handle_response_not_found(request, message)
      if message
        Chef::Log.error message
      else
        Chef::Log.error "Endpoint not found when sending #{request_message request}"
      end
    end

    def handle_response_conn_refused
      Chef::Log.error 'Connection refused.'
      raise BackendError, 'Connection to Grafana refused. Please ensure Grafana is running.'
    end

    def handle_response_unknown(request, code, message)
      if message
        Chef::Log.error(format(message, code: code))
      else
        Chef::Log.error "Response code '#{code}' not handled when sending #{request_message request}"
      end
      raise BackendError
    end
  end
end
