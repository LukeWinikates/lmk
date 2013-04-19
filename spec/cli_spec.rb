require 'spec_helper'
require 'rspec/mocks'

RSpec::Matchers.define :options_like do |test, gist| 
  match do |actual|
    actual.t? == test && actual.g? == gist
  end
end

describe LMK::CLI do
  describe "the exec command" do
    it "joins the command fragments and passes them to the runner" do
      LMK::Runner.stub(:run).with(anything, anything)
      LMK::Runner.should_receive(:run).with("echo \"ham\"", options_like(true, true))
      command = LMK::CLI.start(["exec", "-t", "-g", "echo", "\"ham\""])
    end
  end
end 
