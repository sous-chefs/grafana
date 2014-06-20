
require 'spec_helper'

describe file('/srv/apps/grafana') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'www-data' }
  it { should be_grouped_into 'root' }
end

describe file('/srv/apps/grafana/config.js') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'www-data' }
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
      }
    },

    // elasticsearch url
    // used for storing and loading dashboards, optional
    // For Basic authentication use: http://username:password@domain.com:9200
    elasticsearch: window.location.protocol+"//"+window.location.hostname+":"+window.location.port,

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
