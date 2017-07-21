module Bretelline
  module Builders
    class Solidus < Rails::AppBuilder
      def gemfile
        template "solidus_gemfile.erb", "Gemfile"
      end

      def setup
        solidus
        rspec
      end

      def readme
        template 'README.md.erb', 'README.md'
      end

      private

      def rspec
        bundle_command "exec rails generate rspec:install"
        directory 'spec/support'
        remove_file "spec/rails_helper.rb"
        copy_file 'spec/rails_helper.rb', 'spec/rails_helper.rb'
        prepend_to_file 'spec/spec_helper.rb', "require 'support/simplecov'"
      end

      def solidus
        bundle_command "exec rails g spree:install --sample=false"
        bundle_command "exec rails g solidus:auth:install"
        bundle_command "exec rake railties:install:migrations"
      end
    end
  end
end
