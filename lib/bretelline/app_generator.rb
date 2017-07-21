module Bretelline
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :database, type: :string, aliases: "-d", default: "postgresql",
                            desc: "Configure for selected database (options: #{DATABASES.join('/')})"

    class_option :skip_test, type: :boolean, default: true,
                             desc: "Skip Test Unit"

    class_option :skip_system_test, type: :boolean, default: true,
                                    desc: "Skip system test files"

    class_option :skip_turbolinks, type: :boolean, default: true,
                                   desc: "Skip turbolinks gem"

    class_option :skip_action_cable, type: :boolean, aliases: "-C", default: true,
                                     desc: "Skip Action Cable files"

    def source_paths
      [
        Rails::Generators::AppGenerator.source_root,
        File.expand_path("templates", File.dirname(__FILE__))
      ]
    end

    def finish_template
      invoke :bretelline
      super
    end

    def run_bundle
      # Do nothing, it will be run by the bretelline command
    end

    def bretelline
      bundle_command 'install'
      invoke :create_database
      build :setup
      invoke :migrate_database
    end

    def create_database
      bundle_command "exec rails db:create"
    end

    def migrate_database
      bundle_command "exec rails db:migrate"
    end

    protected

    def get_builder_class
      Bretelline::Builders::Solidus
    end
  end
end
