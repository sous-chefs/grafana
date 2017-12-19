module GrafanaCookbook
  module AlertingApi
    include GrafanaCookbook::ApiHelper

    # Uses the HTTP API and session-based authentication to add a Grafana alerting notification
    # Here's a sample curl statement: curl 'http://localhost/api/alerting-notifications' -X PUT -H 'Content-Type: application/json;charset=utf-8' -H 'Cookie: grafana_sess=807f6bf34a80787e; grafana_user=admin;'
    # --data '{"name":"alertmanager","type":"alertmanager","settings": {"url":"http://alertmanager.domain.tld"}}'
    # Params:
    # +alerting_notification+:: This is a hash of the options used to create the new alerting notification
    # +legacy_http_semantic+:: In older grafana versions (<= 2.0.2) http semantic for create/update was reversed
    # +grafana_options+:: This is a hash with the details used to communicate with the Grafana server
    def add_alerting_notification(alert_notification, legacy_http_semantic, grafana_options)
      grafana_options[:method] = legacy_http_semantic ? 'Put' : 'Post'
      grafana_options[:success_msg] = 'alert notification added successfuly.'
      grafana_options[:unknown_code_msg] = 'AlertingAPI::add_alerting_notification unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/alert-notifications'

      do_request(grafana_options, alert_notification.to_json)
    rescue BackendError
      nil
    end

    # Uses the HTTP API and session-based authentication to update a Grafana alert notification
    # Params:
    # +alerting_notification+:: This is a hash of the options used to update the alert notification
    # +legacy_http_semantic+:: In older grafana versions (<= 2.0.2) http semantic for create/update was reversed
    # +grafana_options+:: A hash of the host, port, user, and password
    def update_alerting_notification(alert_notification, legacy_http_semantic, grafana_options)
      if legacy_http_semantic
        grafana_options[:method] = 'Post'
        grafana_options[:endpoint] = '/api/alert-notifications'
      else
        grafana_options[:method] = 'Put'
        grafana_options[:endpoint] = '/api/alert-notifications/' + alert_notification[:id].to_s
      end
      grafana_options[:success_msg] = 'alert notification added successfuly.'
      grafana_options[:unknown_code_msg] = 'AlertingAPI::update_datasource unchecked response code: %{code}'

      do_request(grafana_options, alert_notification.to_json)
    rescue BackendError
      nil
    end

    # Uses the HTTP API and session-based authentication to delete a Grafana alert notification
    # curl -X GET -H 'Content-Type: application/json;charset=utf-8' -H 'Cookie: grafana_sess=807f6bf34a80787e; grafana_user=admin;'
    # https://localhost:3000/api/alert-notifications/alert_notification[:id]
    # Params:
    # +alerting_notification+:: The id of the alert notification to be deleted
    # +grafana_options+:: A hash of the host, port, user, and password
    def delete_alerting_notification(alert_notification, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'alert notification deleted successfully.'
      grafana_options[:unknown_code_msg] = 'AlertingAPI::delete_datasource unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/alert-notifications/' + alert_notification[:id].to_s

      do_request(grafana_options)
    rescue BackendError
      nil
    end

    # Get a list of all the existing alert notification within Grafana
    # curl -X GET -H 'Content-Type: application/json;charset=utf-8' -H 'Cookie: grafana_sess=807f6bf34a80787e; grafana_user=admin;'
    # https://localhost:3000/api/alert-notifications
    # Params:
    # +grafana_options+:: A hash of the host, port, user, and password
    def get_alerting_notification_list(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'List of alert motification have been successfully retrieved.'
      grafana_options[:unknown_code_msg] = 'Error retrieving list of alert notification.'
      grafana_options[:endpoint] = '/api/alert-notifications/'

      Array(do_request(grafana_options))
    end
  end
end
