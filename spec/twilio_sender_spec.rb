require 'spec_helper'

# This integraiton test runs using the configuration in your ~/.lmkrc file
# you will recieve a text message each time you run this test, so run it sparingly.
describe LMK::TwilioSender do
  context "integration", :integration do
    let(:fake_command) { OpenStruct.new(:ouput => "test message") }
    it "sends a message using the twilio api" do
      LMK::TwilioSender.send fake_command
    end
  end

  describe ".runnable" do
    before { LMK::Config.stub(:from_file) { OpenStruct.new(:valid? => valid) } }

    context "when config is invalid" do
      let(:valid) { false }

      it "is not runnable" do
        LMK::TwilioSender.runnable?.should be_false
      end
    end

    context "when config is valid" do
      let(:valid) { true }

      it "is runnable" do
        LMK::TwilioSender.runnable?.should be_true
      end
    end
  end
end
