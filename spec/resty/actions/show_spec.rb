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
    let(:controller) { Object }
    subject { described_class.new(controller, request) }

    context "with a valid request object" do
      let(:request) { double(:request, params: {}, path: "/path/1") }

      context "when the resource exists" do
        let(:resource) { double(:resource) }

        before { controller.any_instance.stub(:show).with({id: "1"}).and_return(resource) }
        its(:status) { should == 200 }
        its(:resource) { should == resource }
        its(:headers) { should == {} }
      end

      context "when the resource does not exist" do
        before { controller.any_instance.stub(:show).with(id: "1").and_return(nil) }
        its(:status) { should == 404 }
        its(:resource) { should be_nil }
        its(:headers) { should == {} }
      end
    end

    context "with an invalid request object" do
      context "because the path is missing a resource id" do
        let(:request) { double(:request, params: {}, path: "/path") }

        before { controller.any_instance.stub(:show).with(id: nil).and_return(nil) }

        its(:status) { should == 404 }
        its(:resource) { should be_nil }
        its(:headers) { should == {} }
      end
    end
  end
end