module GrafanaCookbook
  module DashboardApi
    include GrafanaCookbook::ApiHelper
    class BackendError < StandardError
    end

    # Fetch the json representation of the dashboard
    # curl -G --cookie "grafana_user=admin; grafana_sess=997bcbbf1c60fcf0;" http://localhost:3000/api/dashboards/db/sample-dashboard
    def get_dashboard(dashboard_options, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Get.new("/api/dashboards/db/#{dashboard_options[:name]}")
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Accept', 'application/json')

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: 'The dashboard has been successfully retrieved.',
        not_found: 'The dashboard does not exist.',
        unknown_code: 'DashboardApi::get_dashboard unchecked response code: %{code}'
      )

      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    #
    def create_dashboard(dashboard_options, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Post.new('/api/dashboards/db')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      dashboard_source_file = File.expand_path("../files/default/#{dashboard_options[:source]}.json", File.dirname(__FILE__))
      dash_hash = {
        'dashboard' => JSON.parse(File.read(dashboard_source_file)),
        'overwrite' => dashboard_options[:overwrite]
      }
      request.body = dash_hash.to_json

      http.set_debug_output $stdout

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: "Dashboard (#{dashboard_options[:name]}) creation was successful.",
        unknown_code: 'DashboardApi::create_dashboard unchecked response code: %{code}'
      )
    rescue BackendError
      nil
    end

    #
    def delete_dashboard(name, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Delete.new("/api/dashboards/db/#{name}")
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Accept', 'application/json')

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        response,
        success: 'Dashboard deletion was successful.',
        unknown_code: 'DashboardApi::delete_dashboard unchecked response code: %{code}'
      )
    rescue BackendError
      nil
    end

    # A couple sanity checks for the grafana_dashboard resource.
    # It will fail with a helpful messages if one of the expectations is violated.
    # Params:
    # +dashboard_options+:: A hash of the dashboard options
    def dashboard_sanity(dashboard_options)
      dashboard_source_file = File.expand_path("../files/default/#{dashboard_options[:source]}.json", File.dirname(__FILE__))
      unless File.exist?(dashboard_source_file)
        fail "#{dashboard_options[:source]} was specified, but #{dashboard_source_file} does not exist!"
      end
      dash_json = JSON.parse(File.read(dashboard_source_file))

      fail "#{dashboard_options[:name]} did not match the name (#{dash_json['title']}) in the json" if dash_json['title'].gsub(' ', '-').downcase != dashboard_options[:name]
    rescue BackendError
      nil
    end
  end
end
