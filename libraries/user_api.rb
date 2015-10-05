module GrafanaCookbook
  module UserApi
    include GrafanaCookbook::ApiHelper

    #
    def add_user(user, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Post.new('/api/admin/users')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = user.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The user has been successfully created.',
        unknown_code: 'UserApi::add_user unchecked response code: %{code}'
      )
      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    #
    def update_user_details(user, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Put.new('/api/users/' + user[:id].to_s)
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = user.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The user has been successfully updated.',
        unknown_code: 'UserApi::update_user unchecked response code: %{code}'
      )
      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    def update_user_password(user, grafana_options)
      # Test user login with provided password.
      # If it succeeds, no need to update password
      user_session_id = login(grafana_options[:host], grafana_options[:port], user[:login], user[:password])
      return if user_session_id

      # If it fails, that means we have to change password
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Put.new('/api/admin/users/' + user[:id].to_s + '/password')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = { password: user[:password] }.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The user has been successfully updated.',
        unknown_code: 'UserApi::update_user unchecked response code: %{code}'
      )
      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    def update_user_permissions(user, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Put.new('/api/admin/users/' + user[:id].to_s + '/permissions')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = { isGrafanaAdmin: user[:isAdmin] }.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The user has been successfully updated.',
        unknown_code: 'UserApi::update_user unchecked response code: %{code}'
      )
      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    #
    def delete_user(user, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Delete.new('/api/admin/users/' + user[:id].to_s)
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = user.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The user has been successfully deleted.',
        unknown_code: 'UserApi::delete_user unchecked response code: %{code}'
      )
      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    # Gets a list of users
    # curl -G --cookie "grafana_user=admin; grafana_sess=5eca2376d310627f;" http://localhost:3000/api/users
    def get_user_list(grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Get.new('/api/users/')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Accept', 'application/json')

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The list of users has been successfully retrieved.',
        unknown_code: 'UserApi::get_admin_user_list unchecked response code: %{code}'
      )
      JSON.parse(response.body)
    rescue BackendError
      nil
    end
  end
end
