require ::File.expand_path('../../spec_helper', __FILE__)

describe file('/srv/apps/grafana') do
  let :owner do
    if os[:family]=="redhat"
      "nginx"
    else
      "www-data"
    end
  end
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by owner }
  it { should be_grouped_into 'root' }
end

describe file('/srv/apps/grafana/config.js') do
  let :owner do
    if os[:family]=="redhat"
      "nginx"
    else
      "www-data"
    end
  end
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by owner }
  it { should be_grouped_into 'root' }
  it { should contain %Q{///// @scratch /configuration/config.js/1
 // == Configuration
 // config.js is where you will find the core Grafana configuration. This file cont
ains parameter that
 // must be set before Grafana is run for the first time.
 ///
define(['settings'],
function (Settings) {


  return new Settings({

    // datasources, you can add multiple
    datasources: {
      graphite: {
        type: 'graphite',
        url: window.location.protocol+"//"+window.location.hostname+":"+window.location.port+"/_graphite",
        default: true
      },
      elasticsearch: {
        type: 'elasticsearch',
        url: window.location.protocol+"//"+window.location.hostname+":"+window.location.port,
        index: 'grafana-index',
        grafanaDB: true
      }
    },

    // default start dashboard
    default_route: '/dashboard/file/default.json',

    // timezoneOFfset:
    // If you experiance problems with zoom, it is probably caused by timezone diff between
    // your browser and the graphite-web application. timezoneOffset setting can be used to have Grafana
    // translate absolute time ranges to the graphite-web timezone.
    // Example:
    //   If TIME_ZONE in graphite-web config file local_settings.py is set to America/New_York, then set
    //   timezoneOffset to "-0500" (for UTC - 5 hours)
    // Example:
    //   If TIME_ZONE is set to UTC, set this to "0000"
    //
    timezoneOffset: null,

    // Elasticsearch index for storing dashboards
    grafana_index: "grafana-index",

    // set to false to disable unsaved changes warning
    unsaved_changes_warning: true,

    // set the default timespan for the playlist feature
    // Example: "1m", "1h"
    playlist_timespan: "1m",

    // If you want to specify password before saving, please specify it bellow
    // The purpose of this password is not security, but to stop some users from accidentally changing dashboards
    admin: {
      password: ''
    },

    // Change window title prefix from 'Grafana - <dashboard title>'
    window_title_prefix: "Grafana - ",

    // specify the limit for dashboard search results
    search: {
      max_results: 20
    },

    // Add your own custom pannels
    plugins: {
      panels: []
    }

  });
});}}
end

describe file('/etc/nginx/sites-enabled/grafana') do
  it { should be_file }
  it { should be_linked_to '/etc/nginx/sites-available/grafana' }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command("curl http://#{$ohaidata[:ipaddress]}/#/dashboard/file/default.json") do
  its(:stdout) { should match /GrafanaCtrl/ }
end
