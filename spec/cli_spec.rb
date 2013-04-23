require 'spec_helper'
require 'rspec/mocks'

describe LMK::CLI do
  describe "the exec command" do
    it "joins the command fragments and passes them to the runner" do
      LMK::Runner.stub(:run).with(anything, anything)
      LMK::Runner.should_receive(:run).with("echo \"ham\"", {})
      command = LMK::CLI.start(["exec", "echo", "\"ham\""])
    end
  end
end 
