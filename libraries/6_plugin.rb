module GrafanaCookbook
  module Plugin
    module_function

    def available?(name, plugin_url, grafana_cli_bin)
      if plugin_url.nil?
        cmd = Mixlib::ShellOut.new("#{grafana_cli_bin} plugins list-remote")
        cmd.run_command
        !cmd.stdout.split("\n").select { |item| item.include?('id:') && item.match(name) }.empty?
      else
        true
      end
    end

    def installed?(name, grafana_cli_bin)
      cmd = Mixlib::ShellOut.new("#{grafana_cli_bin} plugins ls")
      cmd.run_command
      !cmd.stdout.split("\n").select { |item| item.include?('@') && item.match(name) }.empty?
    end

    def build_cli_cmd(name, plugin_url, action, grafana_cli_bin)
      "#{grafana_cli_bin} #{plugin_url.nil? ? "" : "--pluginUrl #{plugin_url}"} plugins #{action} #{name}"
    end
  end
end
