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
        rubocop
        gitignore
        git_setup_and_initial_commit unless options[:skip_git_init]
      end

      def readme
        template 'README.md.erb', 'README.md'
      end

      private

      def solidus
        bundle_command "exec rails g spree:install --sample=false"
        bundle_command "exec rails g solidus:auth:install"
        bundle_command "exec rake railties:install:migrations"
        empty_directory_with_keep_file 'app/overrides'
      end

      def rspec
        bundle_command "exec rails generate rspec:install"
        directory 'spec/support'
        remove_file 'spec/rails_helper.rb'
        copy_file 'spec/rails_helper.rb', 'spec/rails_helper.rb'
        prepend_to_file 'spec/spec_helper.rb', "require 'support/simplecov'\n"
        empty_directory_with_keep_file 'spec/features'
        empty_directory_with_keep_file 'spec/models'
        empty_directory_with_keep_file 'spec/controllers'
        empty_directory_with_keep_file 'spec/jobs'
        empty_directory_with_keep_file 'spec/pages/sections'
        empty_directory_with_keep_file 'spec/factories'
        remove_file 'bin/rails'
        copy_file 'bin_rails', 'bin/rails'
      end

      def ci
        copy_file 'circle.yml', 'circle.yml'
      end

      def rubocop
        copy_file 'rubocop.yml', '.rubocop.yml'
        bundle_command 'exec rubocop -a'
      end

      def gitignore
        copy_file 'gitignore', '.gitignore'
      end

      def git_setup_and_initial_commit
        git :init
        git add: '.'
        git commit: "-m \"Initial commit: bretelline #{app_name}\""
      end
    end
  end
end
