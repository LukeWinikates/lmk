require 'spec_helper'

describe LMK::Config do
  subject { LMK::Config.from_file(File.dirname(__FILE__) + "/fixtures/config") }

  context "reading the file from disk" do
    its(:auth_token)   { should == "hamusando" }
    its(:from)         { should == 25555555555 }
    its(:phone_number) { should == 15555555555 }
    its(:account_sid)  { should == "yakionigiri" }
  end

  describe "validation" do
    it "is valid if all the keys are present" do

    end
  end
end
