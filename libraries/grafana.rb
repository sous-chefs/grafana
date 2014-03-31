module GrafanaExtensions
  def grafana_user
    if node['grafana']['user'].empty?
      unless node['grafana']['webserver'].empty?
        webserver = node['grafana']['webserver']
        node[webserver]['user']
      else
        "nobody"
      end
    else
      node['grafana']['user']
    end
  end
end

[Chef::Recipe, Chef::Resource].each { |l| l.send :include, ::GrafanaExtensions }
