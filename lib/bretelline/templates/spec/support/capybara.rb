Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# Wait some seconds after clicks
Capybara.default_max_wait_time = 5
