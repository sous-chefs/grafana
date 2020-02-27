module GrafanaCookbook
  module CookieHelper
    def self.cookie_name=(name)
      @cookie_name = name
    end

    def self.cookie_name
      @cookie_name || default_cookie_name
    end

    def self.default_cookie_name
      return 'grafana_session' unless grafana_version

      grafana_semver = Gem::Version.new(grafana_version)
      compare_semver = Gem::Version.new('6.0.0')

      return 'grafana_session' if grafana_semver >= compare_semver

      # For versions prior to 6.0.0, return old name
      'grafana_sess'
    end

    def self.grafana_version=(version)
      @grafana_version = version
    end

    def self.grafana_version
      @grafana_version
    end

    module DSLHelper
      def grafana_cookie_name(arg)
        GrafanaCookbook::CookieHelper.cookie_name = arg
      end

      def grafana_version(arg)
        GrafanaCookbook::CookieHelper.grafana_version = arg
      end
    end
    Chef::DSL::Universal.include(GrafanaCookbook::CookieHelper::DSLHelper)
  end
end
