require 'spec_helper'
require 'rspec/mocks'

describe LMK::TwilioSender do
  let(:fake_command) { OpenStruct.new(:concise_output => "concise version" ) }

  describe "send" do
    let(:client) { double(:client) }
    subject { LMK::TwilioSender.new(client) }

    it "sends the concise version" do
      client.should_receive(:send).with(fake_command.concise_output)
      subject.send(fake_command)
    end
  end

  describe "runnable?" do
    subject { LMK::TwilioSender.new OpenStruct.new(:runnable? => runnable) } 

    context "when config is invalid" do
      let(:runnable) { false }

      it { should_not be_runnable }
    end

    context "when config is valid" do
      let(:runnable) { true }

      it { should  be_runnable }
    end
  end
end
