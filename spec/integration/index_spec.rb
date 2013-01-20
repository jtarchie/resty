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

    context "when requesting JSON" do
      it "returns the output as a JSON array" do
        get '/posts.json'
        last_response.status.should == 200
        JSON.parse(last_response.body).should == [
          {"post"=>{"body"=>nil, "id"=>1, "title"=>nil}},
          {"post"=>{"body"=>nil, "id"=>2, "title"=>nil}},
          {"post"=>{"body"=>nil, "id"=>3, "title"=>nil}}
        ]
      end
    end
  end
end