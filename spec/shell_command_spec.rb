require 'spec_helper'

describe LMK::ShellCommand do
  let(:fake_kernel) do
    double(:kernel)
  end

  before { fake_kernel.stub(:puts) { |string| } }

  subject { LMK::ShellCommand.new(command, fake_kernel) }
  context "for succesful shell commands" do
    let(:command) { 'echo "\nhamburglar\n"' }

    its(:output)  { should == "\nhamburglar\n\n" }
    its(:status)  { should == 0 }
    its(:command) { should == command }
    its(:timestamp) { should_not be_nil }
  end

  context "for shell commands that fail" do
    let(:command) { 'cat agedashitofu' }

    its(:output)  { should =~ /No such file or directory/ }
    its(:status)  { should == 1 }
    its(:command) { should == command }
    its(:timestamp) { should_not be_nil }
  end
end
