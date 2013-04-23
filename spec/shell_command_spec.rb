require 'spec_helper'

describe LMK::ShellCommand do
  subject { LMK::ShellCommand.new(command) }
  context "for succesful shell commands" do
    let(:command) { 'echo "hamburglar"' }

    its(:output)  { should == "hamburglar\n" }
    its(:status)  { should == 0 }
    its(:command) { should == command }
  end

  context "for shell commands that fail" do
    let(:command) { 'cat agedashitofu' }

    its(:output)  { should =~ /No such file or directory/ }
    its(:status)  { should == 1 }
    its(:command) { should == command }
  end

  context "when the command has an html_url" do
    let(:html_url) { "http://www.example.com" }
    subject do
      LMK::ShellCommand.new('echo "Hamburglar"').tap do |c|
        c.html_url= html_url
      end
    end
    
    its(:output) { should include(html_url) }
  end
end
