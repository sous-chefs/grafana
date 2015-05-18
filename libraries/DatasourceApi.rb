module GrafanaCookbook
  module DataSourceApi
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

      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
        retry # backs up to just after the "begin"
      end

      if response.is_a? Net::HTTPSuccess
        Chef::Log.info('Datasource addition was successful.')
      elsif response.is_a? Net::HTTPUnauthorized
        Chef::Log.error('Invalid grafana_user and grafana_sess.')
        return
      else
        Chef::Log.error("DataSourceAPI::add_data_source unchecked response code: #{response.code}")
        return
      end
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

      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
        retry # backs up to just after the "begin"
      end

      if response.is_a? Net::HTTPSuccess
        Chef::Log.info('Datasource update was successful.')
      elsif response.is_a? Net::HTTPUnauthorized
        Chef::Log.error('Invalid grafana_user and grafana_sess.')
        return
      else
        Chef::Log.error("DataSourceAPI::update_data_source unchecked response code: #{response.code}")
        return
      end
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

      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
        retry # backs up to just after the "begin"
      end

      if response.is_a? Net::HTTPSuccess
        Chef::Log.info('Datasource deletion was successful.')
      elsif response.is_a? Net::HTTPUnauthorized
        Chef::Log.error('Invalid grafana_user and grafana_sess.')
        return
      else
        Chef::Log.error("DataSourceAPI::delete_data_source unchecked response code: #{response.code}")
        return
      end
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

      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
        retry # backs up to just after the "begin"
      end

      if response.is_a? Net::HTTPSuccess
        Chef::Log.info('List of databases have been successfully retrieved.')
      elsif response.is_a? Net::HTTPUnauthorized
        Chef::Log.error('Invalid grafana_user and grafana_sess.')
      else
        Chef::Log.error('Error retrieving list of databases.')
      end

      JSON.parse(response.body)
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

      if response.is_a? Net::HTTPSuccess
        Chef::Log.info('Login was successful.')
      elsif response.is_a? Net::HTTPUnauthorized
        Chef::Log.error('Invalid username/password.')
        return
      else
        Chef::Log.error("DataSourceAPI::login unchecked response code: #{response.code}")
        return
      end

      # sorry for the fancy hackery - rubists are welcome to make this better
      response['set-cookie'][/grafana_sess=(\w+);/, 1]
    end
  end
end
