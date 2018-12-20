module GrafanaCookbook
  module FolderApi
    include GrafanaCookbook::ApiHelper

    def create_folder(folder, grafana_options)
      grafana_options[:method] = 'Post'
      grafana_options[:success_msg] = 'Folder creation was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::create_folder unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders'

      do_request(grafana_options, folder.to_json)
    rescue BackendError
      nil
    end

    def update_folder(folder, grafana_options)
      grafana_options[:method] = 'PUT'
      grafana_options[:success_msg] = 'Folder update was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::update_folder unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + folder[:uid]

      do_request(grafana_options, folder.to_json)
    rescue BackendError
      nil
    end

    def delete_folder(folder, grafana_options)
      grafana_options[:method] = 'Delete'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::delete_folder unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + folder[:uid]

      do_request(grafana_options)
    rescue BackendError
      nil
    end

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_sess=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/nErXDvCkzz
    def get_folders(grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_uid unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders'

      Array(do_request(grafana_options))
    end

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_sess=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/nErXDvCkzz
    def get_folder(folder, grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_uid unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/' + folder[:uid]

      folder_obj = do_request(grafana_options)

      return if folder_obj['message'] == 'Folder not found'
      folder_obj
    end

    # Fetch the json representation of the folder
    # curl -G --cookie "grafana_user=admin; grafana_sess=997bcbbf1c60fcf0;" http://localhost:3000/api/folders/10
    def get_folder_by_id(folder, grafana_options)
      grafana_options[:method] = 'Get'
      grafana_options[:success_msg] = 'Folder deletion was successful.'
      grafana_options[:unknown_code_msg] = 'FolderApi::get_folder_by_id unchecked response code: %{code}'
      grafana_options[:endpoint] = '/api/folders/id/' + folder[:id]

      folder_obj = do_request(grafana_options)

      return if folder_obj['message'] == 'Folder not found'
      folder_obj
    end
  end
end
