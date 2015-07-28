require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module GoalsProject
  class Application < Rails::Application
    config.generators do |g|
    g.test_framework :rspec,
      :fixtures => false,
      :view_specs => false,
      :helper_specs => false,
      :routing_specs => false,
      :controller_specs => false,
      :request_specs => false
    g.fixture_replacement :factory_girl, :dir => "spec/factories"
  end
  end
end
