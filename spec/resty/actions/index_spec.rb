require 'spec_helper'

describe Resty::Actions::Index do
  describe "when trying to match against a request" do
    let(:request) { double(:request, path: path) }

    subject { described_class.matches?(request) }

    context "that is a GET" do
      before { request.stub(:get?).and_return true }

      context "with a valid path" do
        let(:path) { "/posts" }
        it { should be_true }
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

    before do
      example_app = double(:example_app)
      ExampleApp::PostsController::Index.stub(:new).with({}).and_return(example_app)
      example_app.stub(:resource).and_return(resources)
    end

    context "with a valid request object" do
      let(:request) { double(:request, params: {}, path: "/path") }

      context "when the resources exist" do
        let(:resources) { [ double(:resource) ] }

        its(:status) { should == 200 }
        its(:resource) { should == resources }
        its(:headers) { should == {} }
      end

      context "when the resources does not exist" do
        let(:resources) { [] }

        its(:status) { should == 200 }
        its(:resource) { should == [] }
        its(:headers) { should == {} }
      end
    end

    context "with an invalid request object" do
      context "because the path has a resource id" do
        let(:request) { double(:request, params: {}, path: "/path/1") }
        let(:resources) { nil }

        its(:status) { should == 404 }
        its(:resource) { should be_nil }
        its(:headers) { should == {} }
      end
    end
  end
end