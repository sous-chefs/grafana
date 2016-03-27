module GrafanaCookbook
  module OrganizationApi
    include GrafanaCookbook::ApiHelper

    #
    def add_user_to_orgs(user, grafana_options)
      orgs = get_orgs_list(grafana_options)
      selected_orgs = user[:organizations].map { |user_org| orgs.detect { |org| org['name'] == user_org[:name] } }

      unless selected_orgs
        raise "Could not find any of the #{user[:organizations].map { |user_org| user_org[:name] }} organizations"
      end

      selected_orgs.each do |selected_org|
        select_org(selected_org, grafana_options)
        add_user_to_org(user, grafana_options, selected_org)
      end
    rescue BackendError
      nil
    end

    def add_user_to_org(user, grafana_options, organization)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'The user has been successfully added to organization.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::add_user_to_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/org/users'
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      user_role = user[:organizations].detect { |user_org| user_org[:name] == organization['name'] }[:role]
      payload = { 'role' => user_role, 'loginOrEmail' => user[:login] }
      _do_request(grafana_options, payload.to_json)
    rescue BackendError
      nil
    end

    def update_user_orgs(user, grafana_options)
      orgs = get_orgs_list(grafana_options)
      selected_orgs = user[:organizations].map { |user_org| orgs.detect { |org| org['name'] == user_org[:name] } }

      unless selected_orgs
        raise "Could not find any of the #{user[:organizations].map { |user_org| user_org[:name] }} organizations"
      end

      selected_orgs.each do |selected_org|
        select_org(selected_org, grafana_options)
        users_list = get_org_users(grafana_options)
        exists = false
        current_role = nil
        # check if user exist in the organization
        users_list.each do |user_|
          if user_['login'] == user[:login]
            exists = true
            current_role = user_['role']
          end
          break if exists
        end

        # add user to org if not exist
        unless exists
          add_user_to_org(user, grafana_options, selected_org)
          next
        end

        new_role = user[:organizations].detect { |user_org| user_org[:name] == selected_org['name'] }[:role]
        if new_role == 'DELETE'
          # if user role is set to delete, delete the user from the organization
          delete_user_from_org(user, grafana_options)
        elsif new_role != current_role
          update_user_org(user, grafana_options, new_role)
        end
      end
    rescue BackendError
      nil
    end

    def update_user_org(user, grafana_options, role)
      grafana_options[:method] = 'Patch'
      grafana_options[:success_msg] = 'The user organization has been successfully updated.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::update_user_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/org/users/' + user[:id].to_s
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      payload = { 'role' => role }
      _do_request(grafana_options, payload.to_json)
    rescue BackendError
      nil
    end

    def delete_user_from_org(user, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'The user organization has been successfully deleted.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::delete_user_from_org unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/org/users/' + user[:id].to_s
      grafana_options[:accept_header] = 'application/json;charset=utf-8;'

      _do_request(grafana_options)
    rescue BackendError
      nil
    end

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

      Array(_do_request(grafana_options))
    rescue BackendError
      []
    end

    def get_org_users(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'The list of organization users has been successfully retrieved.'
      grafana_options[:unknown_code_msg] = 'OrganizationApi::get_org_users unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/org/users'

      _do_request(grafana_options)
    rescue BackendError
      []
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
      request = case grafana_options[:method]
                when 'Post'
                  Net::HTTP::Post.new(grafana_options[:endpoint])
                when 'Put'
                  Net::HTTP::Put.new(grafana_options[:endpoint])
                when 'Delete'
                  Net::HTTP::Delete.new(grafana_options[:endpoint])
                when 'Patch'
                  Net::HTTP::Patch.new(grafana_options[:endpoint])
                else
                  Net::HTTP::Get.new(grafana_options[:endpoint])
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
