#
# Cookbook:: grafana
# Resource:: config_unified_alerting
#
# Copyright:: 2018, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures the installed grafana instance

property  :instance_name,                     String,         name_property: true
property  :enabled,                           [true, false],  default: true
property  :disabled_orgs,                     String,         default: ''
property  :admin_config_poll_interval,        String,         default: '60s'
property  :alertmanager_config_poll_interval, String,         default: '60s'
property  :ha_listen_address,                 String,         default: '0.0.0.0:9094'
property  :ha_advertise_address,              String,         default: ''
property  :ha_peers,                          String,         default: ''
property  :ha_peer_timeout,                   String,         default: '15s'
property  :ha_gossip_interval,                String,         default: '200ms'
property  :ha_push_pull_interval,             String,         default: '60s'
property  :execute_alerts,                    [true, false],  default: true
property  :evaluation_timeout,                String,         default: '30s'
property  :max_attempts,                      Integer,        default: 3
property  :min_interval,                      String,         default: '10s'

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['enabled'] ||= '' unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['enabled'] << new_resource.enabled.to_s unless new_resource.enabled.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['disabled_orgs'] ||= '' unless new_resource.disabled_orgs.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['disabled_orgs'] << new_resource.disabled_orgs.to_s unless new_resource.disabled_orgs.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['admin_config_poll_interval'] ||= '' unless new_resource.admin_config_poll_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['admin_config_poll_interval'] << new_resource.admin_config_poll_interval.to_s unless new_resource.admin_config_poll_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['alertmanager_config_poll_interval'] ||= '' unless new_resource.alertmanager_config_poll_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['alertmanager_config_poll_interval'] << new_resource.alertmanager_config_poll_interval.to_s unless new_resource.alertmanager_config_poll_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_listen_address'] ||= '' unless new_resource.ha_listen_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_listen_address'] << new_resource.ha_listen_address.to_s unless new_resource.ha_listen_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_advertise_address'] ||= '' unless new_resource.ha_advertise_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_advertise_address'] << new_resource.ha_advertise_address.to_s unless new_resource.ha_advertise_address.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_peers'] ||= '' unless new_resource.ha_peers.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_peers'] << new_resource.ha_peers.to_s unless new_resource.ha_peers.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_peer_timeout'] ||= '' unless new_resource.ha_peer_timeout.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_peer_timeout'] << new_resource.ha_peer_timeout.to_s unless new_resource.ha_peer_timeout.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_gossip_interval'] ||= '' unless new_resource.ha_gossip_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_gossip_interval'] << new_resource.ha_gossip_interval.to_s unless new_resource.ha_gossip_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_push_pull_interval'] ||= '' unless new_resource.ha_push_pull_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['ha_push_pull_interval'] << new_resource.ha_push_pull_interval.to_s unless new_resource.ha_push_pull_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['execute_alerts'] ||= '' unless new_resource.execute_alerts.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['execute_alerts'] << new_resource.execute_alerts.to_s unless new_resource.execute_alerts.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['evaluation_timeout'] ||= '' unless new_resource.evaluation_timeout.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['evaluation_timeout'] << new_resource.evaluation_timeout.to_s unless new_resource.evaluation_timeout.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['max_attempts'] ||= '' unless new_resource.max_attempts.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['max_attempts'] << new_resource.max_attempts.to_s unless new_resource.max_attempts.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['min_interval'] ||= '' unless new_resource.min_interval.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['unified_alerting']['min_interval'] << new_resource.min_interval.to_s unless new_resource.min_interval.nil?
end
