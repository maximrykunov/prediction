# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require 'rspec/autorun'
require 'capybara/rspec'
# require 'sucker_punch/testing/inline'
# require 'webmock/rspec'
require 'should_not/rspec'


DEFAULT_HOST = "lvh.me"
Capybara.configure do |config|
  # config.javascript_driver = :selenium
  config.javascript_driver = :webkit
  # config.automatic_reload = false

  config.always_include_port = true
  config.app_host = "http://#{ DEFAULT_HOST }"
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # config.before(:all) { DeferredGarbageCollection.start }
  # config.after(:all) do
  #   DeferredGarbageCollection.reconsider
  #   FileUtils.rm_rf(Settings.uploads.temp_path)
  # end

  config.before(:suite) do
    # DatabaseCleaner.strategy = :transaction
    # DatabaseCleaner.strategy = :truncation
    # DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  # Clean up all jobs specs with truncation.
  # config.before(:each, job: true) do
  #   DatabaseCleaner.strategy = :truncation
  # end

  # config.before(:each) do
  #   # DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.start
  #   ActionMailer::Base.deliveries.clear
  #   # Timecop.return
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

  config.around(:each) do |example|
    DatabaseCleaner.strategy = if example.metadata[:js] || example.metadata[:type] == 'feature'
      :truncation
    else
      :transaction
    end
    DatabaseCleaner.start
    ActionMailer::Base.deliveries.clear

    example.run

    Capybara.reset_sessions!
    DatabaseCleaner.clean
  end

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: 'controller'
  # config.include FeatureMacros, type: 'feature'
  # config.include Capybara::Angular::DSL, type: 'feature'
  # config.extend ControllerMacros, type: 'controller'
  # config.include RequestMacros, type: 'request'
end
