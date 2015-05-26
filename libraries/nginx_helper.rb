module NginxHelper
    include Chef::Mixin::ShellOut

    def current_nameservers
      nameservers = Array.new
      output = shell_out!("grep nameserver /etc/resolv.conf| awk '{print $2}'",
                          {:returns => [0, 1]})
      if output.exitstatus == 0
        nameservers = output.stdout.split()
      end
      return nameservers
    end
end

Chef::Recipe.send(:include, ::NginxHelper)
Chef::Provider.send(:include, ::NginxHelper)
Chef::Resource.send(:include, ::NginxHelper)
