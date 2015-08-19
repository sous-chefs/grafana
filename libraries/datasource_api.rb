module GrafanaCookbook
  module DataSourceApi
    include GrafanaCookbook::ApiHelper

    # Uses the HTTP API and session-based authentication to add a Grafana datasource
    # Here's a sample curl statement: curl 'http://localhost/api/datasources' -X PUT -H 'Content-Type: application/json;charset=utf-8' -H 'Cookie: grafana_sess=807f6bf34a80787e; grafana_user=admin;'
    # --data '{"name":"not-influxdb","type":"influxdb_08","url":"http://10.0.0.6:8086","access":"direct","database":"grafana","user":"root","password":"root"}'
    # Params:
    # +db_options+:: This is a hash of the options used to create the new datasource
    # +legacy_http_semantic+:: In older grafana versions (<= 2.0.2) http semantic for create/update was reversed
    # +grafana_options+:: This is a hash with the details used to communicate with the Grafana server
    def add_data_source(db_options, legacy_http_semantic, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      if legacy_http_semantic
        request = Net::HTTP::Put.new('/api/datasources')
      else
        request = Net::HTTP::Post.new('/api/datasources')
      end
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8')
      request.body = db_options.to_json

      # When you want to debug the http request
      # http.set_debug_output $stdout

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'Datasource addition was successful.',
        unknown_code: 'DataSourceAPI::add_data_source unchecked response code: %{code}'
      )
    rescue BackendError
      nil
    end

    # Uses the HTTP API and session-based authentication to update a Grafana datasource
    # Params:
    # +db_options+:: This is a hash of the options used to update the datasource
    # +legacy_http_semantic+:: In older grafana versions (<= 2.0.2) http semantic for create/update was reversed
    # +grafana_options+:: A hash of the host, port, user, and password
    def update_data_source(db_options, legacy_http_semantic, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      if legacy_http_semantic
        request = Net::HTTP::Post.new('/api/datasources')
      else
        request = Net::HTTP::Put.new("/api/datasources/#{db_options[:id]}")
      end
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8')
      request.body = db_options.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'Datasource update was successful.',
        unknown_code: 'DataSourceAPI::update_data_source unchecked response code: %{code}'
      )
    rescue BackendError
      nil
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
        request,
        response,
        success: 'Datasource deletion was successful.',
        unknown_code: 'DataSourceAPI::delete_data_source unchecked response code: %{code}'
      )
    rescue BackendError
      nil
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
        request,
        response,
        success: 'List of datasources have been successfully retrieved.',
        unknown_code: 'Error retrieving list of datasources.'
      )

      JSON.parse(response.body)
    rescue BackendError
      nil
    end
  end
end
