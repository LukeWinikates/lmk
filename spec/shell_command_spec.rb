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
end
