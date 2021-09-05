module Grafana
  module Cookbook
    module Utils
      private

      def nil_or_empty?(*values)
        values.any? { |v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
      end
    end
  end
end
