# Load all SitePrism pages and sections
Dir[
  Rails.root.join('spec/pages/sections/**/*.rb'),
  Rails.root.join('spec/pages/**/*.rb')
].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# Load factories
Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

VCR.configure do |config|
  config.cassette_library_dir = 'spec/support/cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Choose one or more libraries:
    # with.library :active_record
    # with.library :active_model
    # with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end
