module GrafanaCookbook
  module OrganizationApi
    include GrafanaCookbook::ApiHelper

    #
    def add_org(name, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Post.new('/api/org/')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = { 'name' => name }.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'Organization addition was successful.',
        unknown_code: 'OrganizationApi::add_org unchecked response code: %{code}'
      )

      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    #
    def update_org(org_options, grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Put.new('/api/org')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Content-Type', 'application/json;charset=utf-8;')
      request.body = org_options.to_json

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'Organization update was successful.',
        unknown_code: 'OrganizationApi::update_org unchecked response code: %{code}'
      )

      JSON.parse(response.body)
    rescue BackendError
      nil
    end

    # Get a list of the existing organizations
    def get_orgs_list(grafana_options)
      session_id = login(grafana_options[:host], grafana_options[:port], grafana_options[:user], grafana_options[:password])
      http = Net::HTTP.new(grafana_options[:host], grafana_options[:port])
      request = Net::HTTP::Get.new('/api/user/orgs')
      request.add_field('Cookie', "grafana_user=#{grafana_options[:user]}; grafana_sess=#{session_id};")
      request.add_field('Accept', 'application/json')

      response = with_limited_retry tries: 10, exceptions: Errno::ECONNREFUSED do
        http.request(request)
      end

      handle_response(
        request,
        response,
        success: 'The list of organizations has been successfully retrieved.',
        unknown_code: 'OrganizationApi::get_orgs_list unchecked response code: %{code}'
      )

      JSON.parse(response.body)
    rescue BackendError
      nil
    end
  end
end
