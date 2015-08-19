module GrafanaCookbook
  module DashboardApi
    include GrafanaCookbook::ApiHelper

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
        request,
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
      dashboard_source_file = find_dashboard_source_file dashboard_options
      dash_hash = {
        'dashboard' => JSON.parse(File.read(dashboard_source_file)),
        'overwrite' => dashboard_options[:overwrite]
      }
      request.body = dash_hash.to_json

      # http.set_debug_output $stdout

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
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
        request,
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
      dashboard_source_file = find_dashboard_source_file dashboard_options
      unless dashboard_source_file
        checked_paths = lookup_paths(dashboard_options).join(', ')
        if dashboard_options[:path]
          err_msg_prt = "#{dashboard_options[:path]} path"
        else
          err_msg_prt = "#{dashboard_options[:source]} resource name or source"
        end
        fail "dashboard_sanity failure: #{err_msg_prt} was specified, but no dashboard found (checked: #{checked_paths})"
      end
      dash_json = JSON.parse(File.read(dashboard_source_file))

      dash_json_title = dash_json['title'].tr('.', '-').tr(' ', '-').downcase
      if dash_json_title != dashboard_options[:name]
        fail "dashboard_sanity failure: the resource name (#{dashboard_options[:name]}) "\
             "did not match the \"title\" in the json (#{dash_json_title}) or is not a valid Grafana slug. "\
             'See http://docs.grafana.org/reference/http_api/#get-dashboard for more details.'
      end
    rescue BackendError
      nil
    end

    private

    def lookup_paths(dashboard_options)
      if dashboard_options[:path]
        Array(dashboard_options[:path])
      else
        directories = Array(Chef::Config[:cookbook_path])
        Array(directories).map do |path|
          File.expand_path(
            File.join(
              path,
              dashboard_options[:cookbook].to_s,
              'files',
              'default',
              "#{dashboard_options[:source]}.json"
            ),
            File.dirname(__FILE__)
          )
        end
      end
    end

    def find_dashboard_source_file(dashboard_options)
      lookup_paths(dashboard_options).detect { |path| File.exist?(path) }
    end
  end
end
