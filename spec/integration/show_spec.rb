require 'spec_helper'
require 'rack/test'
require 'example_app'

describe "Show a resource" do
  include Rack::Test::Methods

  def app
    Resty::App.new(ExampleApp)
  end

  context "when the resource does not exists" do
    it "returns that its not found" do
      get '/posts/123'
      last_response.status.should == 404
    end
  end

  context "when the resource exists" do
    context "with different content types" do
      it "defaults to HTML" do
        get '/posts/1'
        last_response.status.should == 200
        last_response.headers['Content-Type'].should include "text/html"
        last_response.body.should == "<h1>Post 1</h1>"
      end

      context "with specific formats" do
        it "responds to JSON" do
          get '/posts/1.json'
          last_response.status.should == 200
          last_response.headers['Content-Type'].should include "application/json"
          JSON.parse(last_response.body).should == {
            'id' => "1"
          }
        end

        it "responds to HTML" do
          get '/posts/1.html'
          last_response.status.should == 200
          last_response.headers['Content-Type'].should include "text/html"
          last_response.body.should == "<h1>Post 1</h1>"
        end
      end
    end
  end
end