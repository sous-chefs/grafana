#
# Cookbook:: grafana
# Resource:: config_feature_toggles
#
# Copyright:: 2021, Sous Chefs
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
#Configures the installed grafana instance


property  :instance_name,           String,          name_property: true
property  :enable,                  [String, Array], default: ''
property  :alertingPreviewUpgrade,  [true, false],   default: true
property  :angularDeprecationUI,    [true, false],   default: false
property  :panelTitleSearch,        [true, false],   default: true

action :install do
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles'] ||= {}
  if new_resource.enable.is_a?(Array)
    node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['enable'] = new_resource.enable
  else
    node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['enable'] = [new_resource.enable] unless new_resource.enable.empty?
  end
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['alertingPreviewUpgrade'] ||= '' unless new_resource.alertingPreviewUpgrade.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['alertingPreviewUpgrade'] << new_resource.alertingPreviewUpgrade.to_s unless new_resource.alertingPreviewUpgrade.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['angularDeprecationUI'] ||= '' unless new_resource.angularDeprecationUI.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['angularDeprecationUI'] << new_resource.angularDeprecationUI.to_s unless new_resource.angularDeprecationUI.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['panelTitleSearch'] ||= '' unless new_resource.panelTitleSearch.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['feature_toggles']['panelTitleSearch'] << new_resource.panelTitleSearch.to_s unless new_resource.panelTitleSearch.nil?
end
