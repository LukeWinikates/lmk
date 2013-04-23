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
    let(:auth_token) { "abc" }
    let(:from) { 123 }
    let(:phone_number) { 456 }
    let(:account_sid) { "def" }
    
    subject do
      LMK::Config.new({ :auth_token => auth_token,
                        :from => from,
                        :phone_number => phone_number,
                        :account_sid => account_sid })
    end

    context "when all keys are present" do
      it { should be_valid }
    end

    context "when auth token is missing" do
      let(:auth_token) { nil }
      it { should_not be_valid }
    end

    context "when from is missing" do
      let(:from) { nil }
      it { should_not be_valid }
    end
    
    context "when phone number is missing" do
      let(:phone_number) { nil }
      it { should_not be_valid }
    end

    context "when account_sid is missing" do
      let(:account_sid) { nil }
      it { should_not be_valid }
    end
  end
end
