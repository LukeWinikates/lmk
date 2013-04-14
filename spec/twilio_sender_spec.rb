require 'spec_helper'

# This integraiton test runs using the configuration in your ~/.lmkrc file
# you will recieve a text message each time you run this test, so run it sparingly.
describe LMK::TwilioSender, :integration do
  it "sends a message using the twilio api" do
    subject.send_sms "test message"
  end
end
