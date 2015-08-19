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
    #   :exceptions - Exception or Array of Exception - exceptions to catch (required)
    def with_limited_retry(opts, &block)
      tries = opts.fetch :tries
      exceptions = Array(opts.fetch :exceptions)

      return if tries == 0

      begin
        block.call
      rescue *exceptions
        retry if (tries -= 1) > 0
      end
    end

    # Format a request for use in error/debug message
    # Params:
    # +request+:: Net::HTTPRequest
    def request_message(request)
      "#{request.method} #{request.path}"
    end

    # Log the right thing when
    # Params:
    # +request+:: Net::HTTPRequest
    # +response+:: Net::HTTPResponse -
    # +messages+:: String or  -
    def handle_response(request, response, messages)
      case response
      when Net::HTTPSuccess
        if messages[:success].nil?
          Chef::Log.debug "Request succeeded when sending #{request_message request}"
        else
          Chef::Log.debug messages[:success]
        end
      when Net::HTTPUnauthorized
        if messages[:unauthorized].nil?
          Chef::Log.error 'Invalid grafana_user and grafana_sess.'
        else
          Chef::Log.error messages[:unauthorized]
        end
        raise BackendError
      when Net::HTTPNotFound
        if messages[:not_found].nil?
          Chef::Log.error "Endpoint not found when sending #{request_message request}"
        else
          Chef::Log.error messages[:not_found]
        end
      when nil
        Chef::Log.error 'Connection refused.'
        raise BackendError
      else
        if messages[:unknown_code].nil?
          Chef::Log.error "Response code '#{response.code}' not handled when sending #{request_message request}"
        else
          Chef::Log.error(messages[:unknown_code] % { code: response.code })
        end
        raise BackendError
      end
    end
  end
end
