module Bretelline
  module Builders
    class Solidus < Rails::AppBuilder
      def gemfile
        template "solidus_gemfile.erb", "Gemfile"
      end

      def setup
        solidus
        rspec
        ci
      end

      def readme
        template 'README.md.erb', 'README.md'
      end

      private

      def solidus
        bundle_command "exec rails g spree:install --sample=false"
        bundle_command "exec rails g solidus:auth:install"
        bundle_command "exec rake railties:install:migrations"
      end

      def rspec
        bundle_command "exec rails generate rspec:install"
        directory 'spec/support'
        remove_file "spec/rails_helper.rb"
        copy_file 'spec/rails_helper.rb', 'spec/rails_helper.rb'
        prepend_to_file 'spec/spec_helper.rb', "require 'support/simplecov'"
        empty_directory 'spec/pages/sections'
        empty_directory 'spec/factories'
      end

      def ci
        copy_file 'circle.yml', 'circle.yml'
      end
    end
  end
end
