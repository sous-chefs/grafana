# Cookbook:: grafana
# Library:: helpers
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
    module Helpers
      private

      def default_repo_url
        case node['platform_family']
        when 'rhel', 'amazon', 'fedora'
          'https://rpm.grafana.com'
        when 'debian'
          'https://apt.grafana.com'
        else
          raise ArgumentError, "Unsupported installation platform family #{node['platform_family']}"
        end
      end

      def default_key_url
        case node['platform_family']
        when 'rhel', 'amazon', 'fedora'
          'https://rpm.grafana.com/gpg.key'
        when 'debian'
          'https://apt.grafana.com/gpg.key'
        else
          raise ArgumentError, "Unsupported installation platform family #{node['platform_family']}"
        end
      end
    end
  end
end
