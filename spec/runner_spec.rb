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
    let(:command_text) { "some command" }
    let(:options) { {} }
    let(:fake_command) { ::Struct.new(:output).new("hello!")  }
    let(:sms_service_runnable) { true }

    subject do
      sms_service.stub(:runnable?) { sms_service_runnable }
      config = LMK::Runner::Configuration.new
      config.sms_service = sms_service
      config.gist_service = gist_service
      config.console_service = console_service
      config.shell_service = shell_service

      LMK::Runner.new(config).tap { |r| r.run(command_text, options) }
    end

    before do
      shell_service.stub(:exec).with(command_text) { fake_command  } 
    end

    it "runs the services in the proper order" do
      console_service.should_receive(:puts).with("running command `#{command_text}`").ordered
      shell_service.should_receive(:exec).with(command_text).ordered
      gist_service.should_receive(:send).with(fake_command).ordered.and_return(fake_command)
      sms_service.should_receive(:send).with(fake_command).ordered.and_return(fake_command)
      console_service.should_receive(:puts).with(fake_command.output).ordered
      subject
    end

    context "when sms_service configuration is invalid" do
      let(:sms_service_runnable) { false }
      
      it "does not run the command or the sms service" do
        console_service.should_receive(:puts).with("Configuration invalid. Run `lmk config` for more info") 
        shell_service.should_not_receive(:exec)
        sms_service.should_not_receive(:send)
        subject
      end
    end
  end
end