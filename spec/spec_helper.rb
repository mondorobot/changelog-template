require 'middleman'
require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { :inspector => true, })
end

Capybara.javascript_driver = :poltergeist
Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :poltergeist
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.order = 'random'

  config.before(:suite) do
    Capybara.app_host = 'http://localhost:4567'
    Capybara.current_driver = :poltergeist
    Capybara.run_server = false
  end

end
