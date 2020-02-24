module GrafanaCookbook
  module FolderApi
    include GrafanaCookbook::ApiHelper

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_session=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/nErXDvCkzz
    def get_folders(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_uid unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders'

      folder_list = []
      Array(do_request(grafana_options)).each do |folder|
        folder_list.insert(-1, get_folder(folder, grafana_options))
      end
      folder_list
    end

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_session=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/nErXDvCkzz
    def get_folder(folder, grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_uid unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + get_folder_uid(folder)

      folder_obj = do_request(grafana_options)

      return if folder_obj[:message] == 'Folder not found'
      folder_obj
    end

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_session=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/10
    def get_folder_by_id(folder, grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_id unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/id/' + get_folder_id(folder)

      folder_obj = do_request(grafana_options)

      return if folder_obj[:message] == 'Folder not found'
      folder_obj
    end

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_session=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/10
    def get_folder_by_name(folder_name, grafana_options)
      return_folder = get_folders(grafana_options).select { |folder, _value| get_folder_title(folder) == folder_name }
      return_folder[0]
    end

    def get_folder_uid(folder)
      if folder.key?(:uid)
        folder[:uid]
      elsif folder.key?('uid')
        folder['uid']
      end
    end

    def get_folder_id(folder)
      if folder.key?(:id)
        folder[:id]
      elsif folder.key?('id')
        folder['id']
      end
    end

    def get_folder_title(folder)
      if folder.key?(:title)
        folder[:title]
      elsif folder.key?('title')
        folder['title']
      end
    end

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
      folder[:id] = get_folder_id(folder_obj)
      folder[:uid] = get_folder_uid(folder_obj)
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

    def get_folder_permissions(folder, grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_id unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + get_folder_id(folder) + '/permissions'

      perm_obj = do_request(grafana_options)

      return if perm_obj[:message] == 'Folder not found'
      perm_obj
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
