require 'spec_helper'
require 'rspec/mocks'

describe LMK::Runner do
  let(:sms_service) { Object.new }
  let(:gist_service) { Object.new }
  let(:console_service) { double(:console) }
  let(:shell_service) { double(:shell) }
  let(:command) { double(:command) }
  let(:options) { double(:options) }
  
  describe "#configure" do
    it "can set the different services on the default configuration" do
      LMK::Runner.configure do |config|
        config.sms_service = sms_service
        config.gist_service = gist_service
        config.console_service = console_service
      end

      LMK::Runner.configuration.sms_service.should == sms_service
      LMK::Runner.configuration.gist_service.should == gist_service
      LMK::Runner.configuration.console_service.should == console_service
    end
  end  

  describe ".run" do
    let(:runner) { double(:runner) }

    it "calls .new with the default configuration" do
      LMK::Runner.stub(:new) { runner }
      runner.should_receive(:run).with(command, options)

      LMK::Runner.run(command, options)
    end
  end

  describe "#run" do
    let(:command) { "some command" }
    let(:options) { {} }
    let(:exec_result) { ::Struct.new(:output).new("hello!")  }

    subject do
      config = LMK::Runner::Configuration.new
      config.sms_service = sms_service
      config.gist_service = gist_service
      config.console_service = console_service
      config.shell_service = shell_service

      LMK::Runner.new(config).tap { |r| r.run(command, options) }
    end

    before do
      shell_service.stub(:exec).with(command) { exec_result  } 
    end

    describe "printing to the console" do
      it "prints 'running command `command text` to the console" do
        console_service.should_receive(:puts).with("running command `#{command}`").ordered
        shell_service.should_receive(:exec).with(command).ordered
        console_service.should_receive(:puts).with(exec_result.output).ordered
        subject
      end
    end
  end
end
