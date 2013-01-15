require "spec_helper"

describe Resty::App do
  it "requires a namespace to work with" do
    Resty::App.new(ExampleApp).namespace.should == ExampleApp
  end

  pending "tested with integration tests becauses mocking out Rack requests is hard"
end