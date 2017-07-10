require 'rails/generators/rails/app/app_generator'

module Bretelline
  class AppGenerator < Rails::Generators::AppGenerator
    def source_paths
      [
        Rails::Generators::AppGenerator.source_root,
        File.expand_path("templates", File.dirname(__FILE__))
      ]
    end

    protected

    def get_builder_class
      Bretelline::AppBuilder
    end
  end
end
