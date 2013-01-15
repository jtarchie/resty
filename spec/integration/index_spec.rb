require 'spec_helper'
require 'rack/test'
require 'example_app'

describe "Show a resource" do
  include Rack::Test::Methods

  def app
    Resty::App.new(ExampleApp)
  end

  context "when the resources exists" do
    it "returns the resources found" do
      get '/posts'
      last_response.status.should == 200
      last_response.body.should == '<h1>Post 1</h1><h1>Post 2</h1><h1>Post 3</h1>'
    end
  end
end