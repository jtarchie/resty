require 'spec_helper'

describe "When showing a resource", integration: true do
  context "and the resource does not exists" do
    it "returns that its not found" do
      get '/posts/123'
      last_response.status.should == 404
    end

    context "with a SHA resource id" do
      it "returns that its not found" do
        get '/posts/f0429391-ee0c-4c74-b9e1-3aa102bed145'
        last_response.status.should == 404
      end
    end
  end

  context "and the resource exists" do
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
            "post"=>{
              "body"=>nil,
              "id"=>1,
              "title"=>"Title"
            }
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