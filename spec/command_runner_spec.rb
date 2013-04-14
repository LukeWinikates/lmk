require 'spec_helper'

describe LMK::CommandRunner do
  subject { LMK::CommandRunner.new(command) }
  context "for succesful shell commands" do
    let(:command) { 'echo "hamburglar"' }

    its(:result)  { should == "hamburglar\n" }
    its(:status)  { should == 0 }
    its(:command) { should == command }
  end

  context "for shell commands that fail" do
    let(:command) { 'cat agedashitofu' }

    its(:result)  { should =~ /No such file or directory/ }
    its(:status)  { should == 1 }
    its(:command) { should == command }
  end
end
