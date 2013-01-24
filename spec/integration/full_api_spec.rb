require 'spec_helper'

describe "Using Restful action", integration: true do
  it "reacts like a fully integrated restful library" do
    get "/posts/100.json"
    last_response.status.should == 404
    JSON.parse(last_response.body).should == {}

    get "/posts/new.json"
    last_response.status.should == 200
    JSON.parse(last_response.body).should == {
      "post" => {"id" => nil, "title" => nil, "body" => nil}
    }

    post "/posts.json", post: {id: 100, title: "Title", body: "Body"}
    last_response.status.should == 201
    last_response.headers['Location'].should == "/posts/100.json"
    JSON.parse(last_response.body).should == {
      "post" => {"id" => 100, "title" => "Title", "body" => "Body"}
    }

    get "/posts/100.json"
    last_response.status.should == 200
    JSON.parse(last_response.body).should == {
      "post" => {"id" => 100, "title" => "Title", "body" => "Body"}
    }

    get "/posts/100/edit.json"
    last_response.status.should == 200
    JSON.parse(last_response.body).should == {
      "post" => {"id" => 100, "title" => "Title", "body" => "Body"}
    }

    get "/posts.json"
    last_response.status.should == 200
    JSON.parse(last_response.body).should include({
      "post" => {"id" => 100, "title" => "Title", "body" => "Body"}
    })

    put "/posts/100.json", post: {title: "Title 123", body: "Body 456"}
    last_response.status.should == 201
    last_response.headers['Location'].should == "/posts/100.json"
    JSON.parse(last_response.body).should == {
      "post" =>  {"id" => 100, "title" => "Title 123", "body" => "Body 456"}
    }

    delete "/posts/100.json"
    last_response.status.should == 200
    JSON.parse(last_response.body).should == {
      "post" => {"id" => 100, "title" => "Title 123", "body" => "Body 456"}
    }

    get "/posts/100.json"
    last_response.status.should == 404
    JSON.parse(last_response.body).should == {}
  end
end