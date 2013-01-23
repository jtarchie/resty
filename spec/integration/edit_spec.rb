require 'spec_helper'

describe "When request a resource to edit", integration: true do
  context "and a resource has been initialized" do
    it "returns the resource" do
      get '/posts/1/edit'
      last_response.status.should == 200
      last_response.body.should == "<h1>Post 1</h1>"
    end
  end
end