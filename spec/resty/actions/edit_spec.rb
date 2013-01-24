require 'spec_helper'

describe Resty::Actions::Edit do
  describe "when trying to match against a request" do
    let(:request) { double(:request, path: path) }

    subject { described_class.matches?(request) }

    context "that is a GET" do
      before { request.stub(:get?).and_return true }

      context "with a valid path" do
        let(:path) { "/posts/1/edit" }
        it { should be_true }
      end

      context "with an valid without a resource id" do
        let(:path) { "/posts/edit" }
        it { should be_false }
      end

      context "with an invalid path" do
        let(:path) { "/posts/new" }
        it { should be_false }
      end
    end

    context "that is not a GET" do
      let(:path) { "don't care" }
      before { request.stub(:get?).and_return false }
      it { should be_false }
    end
  end

  context "with an instance of the action" do
    let(:controller) { Resty::Controller.new(ExampleApp, "posts") }
    subject { described_class.new(controller, request) }

    context "with a valid request object" do
      let(:request) { double(:request, params: {}, path: "/path/123/edit") }

      before do
        example_app = double(:example_app)
        ExampleApp::PostsController::Edit.stub(:new).with({"id" => "123"}).and_return(example_app)
        example_app.stub(:resource).and_return(resource)
      end

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
  end
end