# Run Coverage report
if ENV["COVERAGE"]
  require_relative 'rcov_exclude_list.rb'
  exlist = Dir.glob(@exclude_list)
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start do
    exlist.each do |p|
      add_filter p
    end
    add_filter 'spec/dummy'
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Models', 'app/models'
    add_group 'Views', 'app/views'
    add_group 'Libraries', 'lib'
  end
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Requires factories and other useful helpers defined in spree_core.
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/factories'
require 'spree/testing_support/url_helpers'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec

  config.include Spree::TestingSupport::UrlHelpers
  config.use_transactional_fixtures = true
  config.fail_fast = ENV['FAIL_FAST'] || false
end

if ENV["COVERAGE"]
  # Load all files except the ones in exclude list
  require_all(Dir.glob('**/*.rb') - exlist)
end
