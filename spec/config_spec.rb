require 'spec_helper'

describe LMK::Config do
  context "reading the file from disk" do
    let(:file) { File.dirname(__FILE__) + "/fixtures/config" }
    subject { LMK::Config.from_file(file) }
    
    its(:auth_token)   { should == "hamusando" }
    its(:from)         { should == 25555555555 }
    its(:phone_number) { should == 15555555555 }
    its(:account_sid)  { should == "yakionigiri" }

    context "when the file does not exist" do
      let(:file) { "something_arbitrary" }
      it "does not throw" do
        expect { subject }.not_to raise_error
      end

      its(:debug) { should =~ /Config file missing, create #{file}/ } 
    end
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
      its(:missing_values) { should == [:auth_token] }
    end

    context "when from is missing" do
      let(:from) { nil }
      it { should_not be_valid }
      its(:missing_values) { should == [:from] }
    end
    
    context "when phone number is missing" do
      let(:phone_number) { nil }
      it { should_not be_valid }
      its(:missing_values) { should == [:phone_number] }
    end

    context "when account_sid is missing" do
      let(:account_sid) { nil }
      it { should_not be_valid }
      its(:missing_values) { should == [:account_sid] }
    end
  end

  describe "#debug" do
    let(:config) { LMK::Config.new(options) }

    context "with an invalid configuration" do 
      let(:options) { { :from => "abas", :auth_token => "something" } }

      it "should show the missing keys in the diagnostic message" do
        config.debug.should =~ /missing values\:.*phone_number/
        config.debug.should =~ /missing values\:.*account_sid/
      end

      it "should tell the user that it is invalid" do
        config.debug.lines.first.should =~ /LMK Configuration invalid/
      end

      it "should list all the keys and their values" do
        config.debug.should =~ /from: abas/
        config.debug.should =~ /auth_token: something/
      end
    end

    context "with a valid configuration" do
      let(:options) { { :auth_token => "adfasdf",
                        :from => "asdfa",
                        :phone_number => "phone_number",
                        :account_sid => "adfasdf" } }

      it "should tell the user that it is valid" do
        config.debug.lines.first.should =~ /LMK Configuration valid/
      end

      it "should not list any missing keys" do
        config.debug.should =~ /missing values: none+$/
      end
      
      it "should list all the keys and their values" do
        config.debug.should =~ /from: #{options[:from]}/
        config.debug.should =~ /auth_token: #{options[:auth_token]}/
        config.debug.should =~ /phone_number: #{options[:phone_number]}/
        config.debug.should =~ /account_sid: #{options[:account_sid]}/
      end
    end
  end
end
