require 'spec_helper'

describe Resty::Actions::Show do
  describe "when trying to match against a request" do
    let(:request) { double(:request, path: "/path/1") }

    subject { described_class.matches?(request) }

    context "that is a GET" do
      before { request.stub(:get?).and_return true }
      it { should be_true }
    end

    context "that is not a GET" do
      before { request.stub(:get?).and_return false }
      it { should be_false }
    end
  end

  context "with an instance of the action" do
    let(:controller) { Resty::Controller.new(ExampleApp, "posts") }
    subject { described_class.new(controller, request) }

    before do
      example_app = double(:example_app)
      ExampleApp::PostsController::Show.stub(:new).with({"id" => resource_id}).and_return(example_app)
      example_app.stub(:resource).and_return(resource)
    end

    context "with a valid request object" do
      let(:resource_id) { "1" }
      let(:request) { double(:request, params: {}, path: "/path/#{resource_id}") }

      context "when the resource exists" do
        let(:resource) { double(:resource) }

        its(:status) { should == 200 }
        its(:resource) { should == resource }
        its(:headers) { should == {} }
      end

      context "when the resource does not exist" do
        let(:resource) { nil }

        its(:status) { should == 404 }
        its(:resource) { should be_nil }
        its(:headers) { should == {} }
      end
    end

    context "with an invalid request object" do
      context "because the path is missing a resource id" do
        let(:request) { double(:request, params: {}, path: "/path") }
        let(:resource_id) { nil }
        let(:resource) { nil }

        its(:status) { should == 404 }
        its(:resource) { should be_nil }
        its(:headers) { should == {} }
      end
    end
  end
end