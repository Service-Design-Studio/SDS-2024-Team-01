require 'cucumber/rails'
require 'capybara/cucumber'
require 'selenium-webdriver'

# Use the default Rails driver for Capybara
Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:3000'

# Configure DatabaseCleaner to ensure a clean state for each test
begin
  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.clean_with(:truncation)
rescue NameError
  raise 'You need to add database_cleaner-active_record to your Gemfile (in the :test group) if you wish to use it.'
end

# Before each scenario, start a transaction
Cucumber::Rails::Database.javascript_strategy = :truncation