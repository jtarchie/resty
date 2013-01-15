require 'spec_helper'

describe Resty::Actions::Index do
  describe "when trying to match against a request" do
    let(:request) { double(:request) }

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
      let(:request) { double(:request, params: {}, path: "/path") }

      context "when the resources exist" do
        let(:resources) { [ double(:resource) ] }

        before { controller.any_instance.should_receive(:index).with({}).and_return(resources) }
        its(:status) { should == 200 }
        its(:resource) { should == resources }
      end

      context "when the resources does not exist" do
        before { controller.any_instance.should_receive(:index).with({}).and_return([]) }
        its(:status) { should == 200 }
        its(:resource) { should == [] }
      end
    end

    context "with an invalid request object" do
      context "because the path has a resource id" do
        let(:request) { double(:request, params: {}, path: "/path/1") }

        before { controller.any_instance.should_receive(:index).with({}).and_return(nil) }

        its(:status) { should == 404 }
        its(:resource) { should be_nil }
      end
    end
  end
end