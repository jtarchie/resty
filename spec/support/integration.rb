require 'rack/test'
require 'example_app'

module IntegrationTest
  include Rack::Test::Methods

  def app
    Resty::App.new(ExampleApp)
  end

  RSpec.configure { |c| c.include self, integration: true }
end