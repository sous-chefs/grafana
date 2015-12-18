module GrafanaCookbook
  module OrganizationApi
    include GrafanaCookbook::ApiHelper

    #
    def add_org(organization, grafana_options)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'Organization addition was successful.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::add_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/orgs'

      _do_request(grafana_options, organization.to_json)
    rescue BackendError
      nil
    end

    #
    def update_org(organization, grafana_options)
      grafana_options[:method] = 'Put'
      grafana_options[:success_msg] = 'Organization update was successful.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::update_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/orgs/' + organization[:id].to_s

      _do_request(grafana_options, organization.to_json)
    rescue BackendError
      nil
    end

    #
    def delete_org(organization, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'Organization deletion was successful.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::delete_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/orgs/' + organization[:id].to_s

      _do_request(grafana_options)
    rescue BackendError
      nil
    end

    # Get a list of the existing organizations
    def get_orgs_list(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'The list of organizations has been successfully retrieved.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::get_orgs_list unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/orgs/'

      _do_request(grafana_options)
    rescue BackendError
      nil
    end

    # Sets the current organization in context of grafana
    def select_org(organization, grafana_options)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'Organization selected'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::select_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/user/using/' + organization['id'].to_s

      _do_request(grafana_options, organization.to_json)
    rescue BackendError
      nil
    end

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
