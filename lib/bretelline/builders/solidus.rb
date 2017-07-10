module Bretelline
  module Builders
    class Solidus < Rails::AppBuilder
      def gemfile
        template "solidus_gemfile.erb", "Gemfile"
      end

      def install_engine
        bundle_command "exec rails g spree:install"
        bundle_command "exec rails g solidus:auth:install"
        bundle_command "exec rake railties:install:migrations"
      end

      def readme
        template 'README.md.erb', 'README.md'
      end
    end
  end
end
