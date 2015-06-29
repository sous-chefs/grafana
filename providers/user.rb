include GrafanaCookbook::UserApi

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create_if_missing do
  grafana_options = {
    host: new_resource.host,
    port: new_resource.port,
    user: new_resource.user,
    password: new_resource.password
  }
  user_options = {
    name: new_resource.full_name,
    email: new_resource.email,
    login: new_resource.login,
    password: new_resource.passwd
  }
  if new_resource.global
    global_users = get_global_user_list(grafana_options)

    exists = false
    global_users.each do |user|
      exists = true if user['login'] == new_resource.login
    end
    unless exists
      converge_by("Creating global user #{new_resource.login}") do
        add_global_user(user_options, grafana_options)
      end
    end
  else
    Chef::Log.error 'Non-global user creation is not currently supported'
  end
end
