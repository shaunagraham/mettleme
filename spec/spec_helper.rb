ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

# Loading more in this block will cause your tests to run faster. However,
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.
Spork.prefork do
  require 'rspec/rails'
  require 'shoulda'
  require 'clearance/testing/helpers'
  require 'paperclip/matchers'
  require Rails.root.join 'spec/support/matchers'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Extend clearance helper methods before including them in spec helpers
  module Clearance
    module Testing
      module Helpers
        # The original clearance helper users :email_confirmed_user,
        # which is depreceated: overide the method to stop depreciation
        # warnings when specs are run.
        #
        # Also store the authenticated user in an instance variable.
        def sign_in(user = nil)
          @user = sign_in_as(user || create(:user))
        end
      end
    end
  end

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    
    # Extra matchers
    config.include FactoryGirl::Syntax::Methods
    config.include Clearance::Testing::Helpers
    config.include Paperclip::Shoulda::Matchers 
    config.include MettleMe::RSpec::Matchers
    
    # Clear action mailer deliveries array before each spec
    config.before(:each) { ActionMailer::Base.deliveries.clear }    
  end  
end

# This code will be run each time you run your specs.
Spork.each_run do
  # Shortcut method for action mailer deliveries array.
  def mailer_deliveries
    ActionMailer::Base.deliveries
  end  
end