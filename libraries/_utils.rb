# Cookbook:: grafana
# Library:: _utils
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

module Grafana
  module Cookbook
    module Utils
      private

      # Check if a given object(s) are either Nil or Empty
      #
      # @return [true, false] Nil or Empty check result
      #
      def nil_or_empty?(*values)
        values.any? { |v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
      end

      # Check if a given gem is installed and available for require
      #
      # @return [true, false] Gem installed result
      #
      def gem_installed?(gem_name)
        !Gem::Specification.find_by_name(gem_name).nil?
      rescue Gem::LoadError
        false
      end

      # Return whether we are being called from the action_class or the outer resource class
      #
      # @return [true, false] True if we are being called from the action_class, otherwise false
      #
      def action_class?
        instance_variable_defined?(:@new_resource)
      end

      # Get the default configuration path for the relevant resource
      #
      # @return [String, Array<String>] Default configuration path for resource
      #
      def resource_default_config_path
        type_string = instance_variable_defined?(:@new_resource) ? new_resource.declared_type.to_s : resource_name.to_s
        config_path = Array(type_string.gsub(/(grafana_)(config_)?/, '').split('_').join('.'))

        Chef::Log.debug("resource_default_config_path: Generated config path #{config_path}")
        raise if nil_or_empty?(config_path)

        config_path
      end

      # Get the actual configuration path for the relevant resource
      #
      # @return [String, Array<String>] Actual configuration path for resource
      #
      def resource_config_path
        path_override = if !action_class? && respond_to?(:resource_config_path_override)
                          resource_config_path_override
                        elsif action_class? && new_resource.respond_to?(:resource_config_path_override)
                          new_resource.resource_config_path_override
                        end

        return resource_default_config_path unless path_override

        raise ArgumentError, "Path override should be specified as an Array, got [#{path_override.class}] #{path_override}" unless path_override.is_a?(Array)

        path_override
      end

      # Get the actual property translation matrix for the resource (if defined)
      #
      # @return [Hash] Property translation matrix
      #
      def resource_translation_matrix
        translation_matrix = if !action_class? && respond_to?(:resource_config_properties_translate)
                               resource_config_properties_translate
                             elsif action_class? && new_resource.respond_to?(:resource_config_properties_translate)
                               new_resource.resource_config_properties_translate
                             end

        return unless translation_matrix

        raise "The property translation matrix should be defined as a Hash, got #{translation_matrix.class}" unless translation_matrix.is_a?(Hash)

        translation_matrix
      end
    end
  end
end
