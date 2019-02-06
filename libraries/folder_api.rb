module GrafanaCookbook
  module FolderApi
    include GrafanaCookbook::ApiHelper

    def create_folder(folder, grafana_options)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'Folder creation was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::create_folder unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders'

      folder_obj = do_request(grafana_options, folder.to_json)
      folder[:id] = get_folder_id(folder_obj)
      folder[:uid] = get_folder_uid(folder_obj)
      update_folder_permissions(folder, grafana_options) if folder[:permissions]
    rescue BackendError
      nil
    end

    def update_folder(folder, grafana_options)
      grafana_options[:method] = 'Put'
      grafana_options[:success_msg] = 'Folder update was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::update_folder unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + get_folder_uid(folder)

      folder_obj = do_request(grafana_options, folder.to_json)
      update_folder_permissions(folder, grafana_options) if folder[:permissions]
    rescue BackendError
      nil
    end

    def update_folder_permissions(folder, grafana_options)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'Folder permissions update was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::update_folder_permissions unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + get_folder_uid(folder) + '/permissions'

      do_request(grafana_options, folder[:permissions].to_json)
    rescue BackendError
      nil
    end

    def delete_folder(folder, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::delete_folder unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + get_folder_uid(folder)

      do_request(grafana_options)
    rescue BackendError
      nil
    end
  end
end
