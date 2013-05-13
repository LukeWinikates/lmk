require 'spec_helper'
require 'rspec/mocks'

describe LMK::Runner do
  let(:sms) { double(:sms) }
  let(:gist) { double(:gist) }
  let(:stdout) { double(:console) }

  let(:stdin) { double(:stdin) }
  let(:shell) { double(:shell) }
  let(:command) { double(:command) }
  let(:sms_service_runnable) { true }

  let(:options) do
    {
      :stdin => stdin,
      :stdout => stdout,
      :shell => shell,
      :sms => sms,
      :gist => gist
    }
  end

  before do
    sms.stub(:runnable?) { sms_service_runnable }
  end

  let(:configuration) do
    LMK::Runner::Configuration.new options
  end

  subject do
    LMK::Runner.new configuration
  end

  describe "#run" do
    let(:command_text) { "some command" }
    let(:fake_command) { ::Struct.new(:output).new("hello!")  }

    before do
      shell.stub(:exec).with(command_text) { fake_command  } 
    end

    it "runs the services in the proper order" do
      stdout.should_receive(:puts).with("running command `#{command_text}`").ordered
      shell.should_receive(:exec).with(command_text).ordered
      gist.should_receive(:send).with(fake_command).ordered.and_return(fake_command)
      sms.should_receive(:send).with(fake_command).ordered.and_return(fake_command)
      subject.run(command_text)
    end

    context "when sms_service configuration is invalid" do
      let(:sms_service_runnable) { false }

      it "does not run the command or the sms service" do
        stdout.should_receive(:puts).with("Configuration invalid. Run `lmk config` for more info") 
        shell.should_not_receive(:exec)
        sms.should_not_receive(:send)
        subject.run(command_text)
      end
    end
  end

  describe "send" do
    let(:piped_message) { "foobar\npiyo\nhoge" }
    let(:fake_command) { ::Struct.new(:output).new("hi") }

    it "runs the gist and sms services" do
      stdin.should_receive(:read).with().and_return(piped_message)
      stdout.should_receive(:puts).with(piped_message)
      LMK::SimpleCommand.should_receive(:new).with(piped_message).and_return { fake_command} 
      gist.should_receive(:send).with(fake_command).ordered.and_return(fake_command)
      sms.should_receive(:send).with(fake_command).ordered.and_return(fake_command)
      subject.send_from_pipe
    end
  end
end
