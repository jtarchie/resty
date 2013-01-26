require 'spec_helper'

describe "When request causes an error", integration: true do
  context "because the controller did not exist" do
    it "returns a not found" do
      get '/entries'
      last_response.status.should == 404
      last_response.body.should == ""

      get '/entries/1.json'
      last_response.status.should == 404
      JSON.parse(last_response.body).should == {}

      get '/entries/1/edit'
      last_response.status.should == 404
      last_response.body.should == ""

      post '/entries.json'
      last_response.status.should == 404
      JSON.parse(last_response.body).should == {}

      put '/entries/1'
      last_response.status.should == 404
      last_response.body.should == ""
    end
  end

  context "because no action responds to the request" do
    it "returns a service unavailable" do
      post '/entries/1/asdfasdfasdfsadfasdft'
      last_response.status.should == 501
      last_response.body.should == ""
    end
  end

  context "because the request format does not exist" do
    it "returns a empty body" do
      get '/entries/1.format'
      last_response.status.should == 404
      last_response.body.should == ''
    end
  end

  context "because a controller doesn't implement an action" do
    it "returns a service unavailable" do
      get '/users'
      last_response.status.should == 501
      last_response.body.should == ''
    end
  end

  context "when creating a resource fails" do
    it "returns an unprocessible entity" do
      post '/posts'
      last_response.status.should == 422
      last_response.body.should == ''
    end
  end
end