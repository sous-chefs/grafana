#
# Cookbook:: grafana
# Resource:: config_external_image_storage
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

property  :instance_name,           String,         name_property: true
property  :storage_provider,        String,         default: 's3'
property  :region,                  String,         required: true
property  :bucket,                  String
property  :bucket_url,              String
property  :path,                    String
property  :access_key,              String
property  :secret_key,              String

action :install do
  Chef::Log.fatal('external_image_storage_s3 : Specify either bucket or bucket_url') if new_resource.bucket.nil? && new_resource.bucket_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage'] ||= {}
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['storage_provider'] ||= '' unless new_resource.storage_provider.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['storage_provider'] << new_resource.storage_provider.to_s unless new_resource.storage_provider.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['region'] ||= '' unless new_resource.region.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['region'] << new_resource.region.to_s unless new_resource.region.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['bucket'] ||= '' unless new_resource.bucket.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['bucket'] << new_resource.bucket.to_s unless new_resource.bucket.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['bucket_url'] ||= '' unless new_resource.bucket_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['bucket_url'] << new_resource.bucket_url.to_s unless new_resource.bucket_url.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['path'] ||= '' unless new_resource.path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['path'] << new_resource.path.to_s unless new_resource.path.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['access_key'] ||= '' unless new_resource.access_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['access_key'] << new_resource.access_key.to_s unless new_resource.access_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['secret_key'] ||= '' unless new_resource.secret_key.nil?
  node.run_state['sous-chefs'][new_resource.instance_name]['config']['external_image_storage']['secret_key'] << new_resource.secret_key.to_s unless new_resource.secret_key.nil?
end
