module GrafanaCookbook
  module DashboardApi
    def create_dashboard(_dashboard_options, grafana_options)
      _session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      # do something
    end
  end
end
