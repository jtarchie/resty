require 'spec_helper'

describe "When request a new resource", integration: true do
  context "and a resource has been initialized" do
    it "returns the resource" do
      get '/posts/new'
      last_response.status.should == 200
      last_response.body.should == "<h1>Post not persisted</h1>"
    end
  end
end