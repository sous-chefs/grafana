module GrafanaCookbook
  module Plugin
    module_function

    def available?(name, grafana_cli_bin)
      cmd = Mixlib::ShellOut.new("#{grafana_cli_bin} plugins list-remote")
      cmd.run_command
      !cmd.stdout.split("\n").select { |item| item.include?('id:') && item.match(name) }.empty?
    end

    def installed?(name, grafana_cli_bin)
      cmd = Mixlib::ShellOut.new("#{grafana_cli_bin} plugins ls")
      cmd.run_command
      !cmd.stdout.split("\n").select { |item| item.include?('@') && item.match(name) }.empty?
    end

    def build_cli_cmd(name, action, grafana_cli_bin)
      "#{grafana_cli_bin} plugins #{action} #{name}"
    end
  end
end
