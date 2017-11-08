module GrafanaCookbook
  module DashboardApi
    include GrafanaCookbook::ApiHelper

    #
    def create_update_dashboard(dashboard, grafana_options)
      # Find dashboard from file and build payload
      dashboard_source_file = find_dashboard_source_file dashboard
      dashboard_options = {
        'dashboard' => JSON.parse(File.read(dashboard_source_file)),
        'overwrite' => dashboard[:overwrite],
      }

      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'Dashboard creation was successful.'
      grafana_options[:unknown_code_msg] = 'DashboardApi::create_dashboard unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/dashboards/db'

      do_request(grafana_options, dashboard_options.to_json)
    rescue BackendError
      nil
    end

    #
    def delete_dashboard(dashboard, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'Dashboard deletion was successful.'
      grafana_options[:unknown_code_msg] = 'DashboardApi::delete_dashboard unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/dashboards/db/' + dashboard[:name]

      do_request(grafana_options)
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
        err_msg_prt = if dashboard_options[:path]
                        "#{dashboard_options[:path]} path"
                      else
                        "#{dashboard_options[:source]} resource name or source"
                      end
        raise "dashboard_sanity failure: #{err_msg_prt} was specified, but no dashboard found (checked: #{checked_paths})"
      end
      dash_json = JSON.parse(File.read(dashboard_source_file))

      dash_json_title = dash_json['title'].tr('.', '-').tr(' ', '-').downcase
      if dash_json_title != dashboard_options[:name]
        raise "dashboard_sanity failure: the resource name (#{dashboard_options[:name]}) "\
             "did not match the \"title\" in the json (#{dash_json_title}) or is not a valid Grafana slug. "\
             'See http://docs.grafana.org/reference/http_api/#get-dashboard for more details.'
      end
    rescue BackendError
      nil
    end

    # Fetch the json representation of the dashboard
    # curl -G --cookie "grafana_user=admin; grafana_sess=997bcbbf1c60fcf0;" http://localhost:3000/api/dashboards/db/sample-dashboard
    def get_dashboard(dashboard, grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Dashboard deletion was successful.'
      grafana_options[:unknown_code_msg] = 'DashboardApi::delete_dashboard unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/dashboards/db/' + dashboard[:name]

      dash = do_request(grafana_options)

      return if dash['message'] == 'Dashboard not found'
      dash
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
