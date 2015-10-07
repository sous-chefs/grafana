module GrafanaCookbook
  module DataSourceApi
    include GrafanaCookbook::ApiHelper

    # Uses the HTTP API and session-based authentication to add a Grafana datasource
    # Here's a sample curl statement: curl 'http://localhost/api/datasources' -X PUT -H 'Content-Type: application/json;charset=utf-8' -H 'Cookie: grafana_sess=807f6bf34a80787e; grafana_user=admin;'
    # --data '{"name":"not-influxdb","type":"influxdb_08","url":"http://10.0.0.6:8086","access":"direct","database":"grafana","user":"root","password":"root"}'
    # Params:
    # +datasource+:: This is a hash of the options used to create the new datasource
    # +legacy_http_semantic+:: In older grafana versions (<= 2.0.2) http semantic for create/update was reversed
    # +grafana_options+:: This is a hash with the details used to communicate with the Grafana server
    def add_datasource(datasource, legacy_http_semantic, grafana_options)
      if legacy_http_semantic
        grafana_options[:method] = 'Put'
      else
        grafana_options[:method] = 'Post'
      end
      grafana_options[:success_msg] = 'Datasource addition was successful.'
      grafana_options[:unknown_code_msg] = 'DataSourceAPI::add_datasource unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/datasources'

      _do_request(grafana_options, datasource.to_json)
    rescue BackendError
      nil
    end

    # Uses the HTTP API and session-based authentication to update a Grafana datasource
    # Params:
    # +datasource+:: This is a hash of the options used to update the datasource
    # +legacy_http_semantic+:: In older grafana versions (<= 2.0.2) http semantic for create/update was reversed
    # +grafana_options+:: A hash of the host, port, user, and password
    def update_datasource(datasource, legacy_http_semantic, grafana_options)
      if legacy_http_semantic
        grafana_options[:method] = 'Post'
        grafana_options[:endpoint] = '/api/datasources'
      else
        grafana_options[:method] = 'Put'
        grafana_options[:endpoint] = '/api/datasources/' + datasource[:id].to_s
      end
      grafana_options[:success_msg] = 'Datasource update was successful.'
      grafana_options[:unknown_code_msg] = 'DataSourceAPI::update_datasource unchecked response code: %{code}'

      _do_request(grafana_options, datasource.to_json)
    rescue BackendError
      nil
    end

    # Uses the HTTP API and session-based authentication to delete a Grafana datasource
    # Params:
    # +datasource+:: The id of the datasource to be deleted
    # +grafana_options+:: A hash of the host, port, user, and password
    def delete_datasource(datasource, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'Datasource deletion was successful.'
      grafana_options[:unknown_code_msg] = 'DataSourceAPI::delete_datasource unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/datasources/' + datasource[:id].to_s

      _do_request(grafana_options)
    rescue BackendError
      nil
    end

    # Get a list of all the existing datasources within Grafana
    # curl -G http://localhost:3000/api/datasources --cookie "grafana_user=admin; grafana_sess=5945ea31879f4779"
    # Params:
    # +grafana_options+:: A hash of the host, port, user, and password
    def get_datasource_list(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'List of datasources have been successfully retrieved.'
      grafana_options[:unknown_code_msg] = 'Error retrieving list of datasources.'
      grafana_options[:endpoint] = '/api/datasources/'

      _do_request(grafana_options)
    end

    # Generic method to build, perform and handle response of any API requests
    # Params:
    # +grafana_options+:: A hash of the host, port, user, and password as well as request parameters
    def _do_request(grafana_options, payload=nil)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      case grafana_options[:method]
      when 'Post'
        request = Net::HTTP::Post.new(grafana_options[:endpoint])
      when 'Put'
        request = Net::HTTP::Put.new(grafana_options[:endpoint])
      when 'Delete'
        request = Net::HTTP::Delete.new(grafana_options[:endpoint])
      else
        request = Net::HTTP::Get.new(grafana_options[:endpoint])
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
      JSON.parse(response.body)
    rescue BackendError
      nil
    end
  end
end
