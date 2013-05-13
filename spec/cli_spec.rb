require 'spec_helper'
require 'rspec/mocks'

describe LMK::CLI do
  let(:runner) { double(:runner) }

  before do
    LMK::CLI.runner = runner
  end

  describe "the exec command" do
    it "joins the command fragments and passes them to the runner" do
      runner.should_receive(:run).with("echo \"ham\"")
      command = LMK::CLI.start(["exec", "echo", "\"ham\""])
    end
  end

  describe "the config command" do
    let(:config) { double(:config) }
    let(:message) { "validation message from the config" }

    context "when the config is invalid" do
      it "shows a message listing the missing config keys" do
        LMK::Config.stub(:from_file) { config }
        config.stub(:debug) { message }
        Kernel.stub(:puts)
        Kernel.should_receive(:puts).with(message)
        LMK::CLI.start(["config"])
      end
    end
  end

  describe "the send command" do
    let(:piped_result) { Object.new }
    subject { LMK::CLI.start ["send"] }

    it "calls Runner.send with the piped result" do
      runner.should_receive :send_from_pipe
      subject
    end
  end
end 
