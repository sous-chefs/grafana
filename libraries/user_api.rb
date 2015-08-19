module GrafanaCookbook
  module UserApi
    include GrafanaCookbook::ApiHelper

    #
    def add_global_user(person, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Post.new('/api/admin/users')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = person.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The admin user has been successfully created.',
        unknown_code: 'UserApi::add_admin_user unchecked response code: %{code}'
      )

      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    # Gets a list of global users
    # curl -G --cookie "grafana_user=admin; grafana_sess=5eca2376d310627f;" http://localhost:3000/api/admin/users
    def get_global_user_list(grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Get.new('/api/admin/users')
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
