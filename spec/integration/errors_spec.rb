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
end