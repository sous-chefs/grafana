module GrafanaCookbook
  module UserApi
    include GrafanaCookbook::ApiHelper

    def add_user(user, grafana_options)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'The user has been successfully created.'
      grafana_options[:unknown_code_msg] = 'UserApi::add_user unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/admin/users'
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      do_request(grafana_options, user.to_json)
    rescue BackendError
      nil
    end

    def update_user_details(user, grafana_options)
      grafana_options[:method] = 'Put'
      grafana_options[:success_msg] = 'The user has been successfully updated.'
      grafana_options[:unknown_code_msg] = 'UserApi::update_user unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/users/' + user[:id].to_s
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      do_request(grafana_options, user.to_json)
    rescue BackendError
      nil
    end

    def update_user_password(user, grafana_options)
      # Test user login with provided password.
      # If it succeeds, no need to update password
      user_session_id = login(grafana_options[:host], grafana_options[:port], user[:login], user[:password])
      return if user_session_id

      # If it fails, that means we have to change password
      grafana_options[:method] = 'Put'
      grafana_options[:success_msg] = 'User\'s password has been successfully updated.'
      grafana_options[:unknown_code_msg] = 'UserApi::update_user unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/admin/users/' + user[:id].to_s + '/password'
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      do_request(grafana_options, { password: user[:password] }.to_json)
    rescue BackendError
      nil
    end

    def update_user_permissions(user, grafana_options)
      grafana_options[:method] = 'Put'
      grafana_options[:success_msg] = 'User\'s permissions have been successfully updated'
      grafana_options[:unknown_code_msg] = 'UserApi::update_user unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/admin/users/' + user[:id].to_s + '/permissions'
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      do_request(grafana_options, { isGrafanaAdmin: user[:isAdmin] }.to_json)
    rescue BackendError
      nil
    end

    def delete_user(user, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'The user has been successfully deleted.'
      grafana_options[:unknown_code_msg] = 'UserApi::delete_user unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/admin/users/' + user[:id].to_s
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      do_request(grafana_options, user.to_json)
    rescue BackendError
      nil
    end

    # curl -G --cookie "grafana_user=admin; grafana_sess=5eca2376d310627f;" http://localhost:3000/api/users
    def get_user_list(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'The list of users has been successfully retrieved.'
      grafana_options[:unknown_code_msg] = 'UserApi::get_admin_user_list unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/users/'
      grafana_options[:accept_header] = 'application/json'

      do_request(grafana_options)
    rescue BackendError
      nil
    end
  end
end
