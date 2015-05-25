module GrafanaCookbook
  module DataSourceApi
    BackendError = Class.new StandardError

    # Uses the HTTP API and session-based authentication to add a Grafana datasource
    # Here's a sample curl statement: curl 'http://localhost/api/datasources' -X PUT -H 'Content-Type: application/json;charset=utf-8' -H 'Cookie: grafana_sess=807f6bf34a80787e; grafana_user=admin;'
    # --data '{"name":"not-influxdb","type":"influxdb_08","url":"http://10.0.0.6:8086","access":"direct","database":"grafana","user":"root","password":"root"}'
    # Params:
    # +db_options+:: This is a hash of the options used to create the new datasource
    # +grafana_options+:: This is a hash with the details used to communicate with the Grafana server
    def add_data_source(db_options, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Put.new('/api/datasources')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8')
      request.body = db_options.to_json

      # When you want to debug the http request
      # http.set_debug_output $stdout

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: "Datasource addition was successful.",
        unknown_code: "DataSourceAPI::add_data_source unchecked response code: %{code}"
      )
    rescue BackendError
    end

    # Uses the HTTP API and session-based authentication to update a Grafana datasource
    # Params:
    # +db_options+:: This is a hash of the options used to update the datasource
    # +grafana_options+:: A hash of the host, port, user, and password
    def update_data_source(db_options, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Post.new('/api/datasources')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8')
      request.body = db_options.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: "Datasource update was successful.",
        unknown_code: "DataSourceAPI::update_data_source unchecked response code: %{code}"
      )
    rescue BackendError
    end

    # Uses the HTTP API and session-based authentication to delete a Grafana datasource
    # Params:
    # +db_id+:: The id of the datasource to be deleted
    # +grafana_options+:: A hash of the host, port, user, and password
    def delete_data_source(db_id, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Delete.new("/api/datasources/#{db_id}")
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Accept', 'application/json')

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: "Datasource deletion was successful.",
        unknown_code: "DataSourceAPI::add_data_source unchecked response code: %{code}"
      )
    rescue BackendError
    end

    # Get a list of all the existing datasources within Grafana
    # curl -G http://localhost:3000/api/datasources --cookie "grafana_user=admin; grafana_sess=5945ea31879f4779"
    # Params:
    # +grafana_options+:: A hash of the host, port, user, and password
    def get_data_source_list(grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Get.new('/api/datasources')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: "List of databases have been successfully retrieved.",
        unknown_code: "Error retrieving list of databases."
      )

      JSON.parse(response.body)
    rescue BackendError
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

      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
        retry # backs up to just after the "begin"
      end

      handle_response(
        response,
        success: "Login was successful.",
        unknown_code: "DataSourceAPI::login unchecked response code: %{code}"
      )

      # sorry for the fancy hackery - rubists are welcome to make this better
      response['set-cookie'][/grafana_sess=(\w+);/, 1]
    rescue BackendError
    end

    private

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

    def handle_response(response, messages)
      case response
      when Net::HTTPSuccess
        Chef::Log.info message[:success]
      when Net::HTTPUnauthorized
        Chef::Log.error "Invalid grafana_user and grafana_sess."
        raise BackendError
      when nil
        Chef::Log.error "Connection refused."
        raise BackendError
      else
        Chef::Log.error(message[:unknown_code] % {code: response.code})
        raise BackendError
      end
    end
  end
end
