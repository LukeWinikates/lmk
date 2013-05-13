require 'spec_helper'

describe LMK::SimpleCommand do
  subject {LMK::SimpleCommand.new("apples")}

  its(:output) { should == "apples" }
  its(:timestamp) { should_not be_nil} 
  its(:command) { should == "(piped from shell)" }
  its(:full_output) { should_not be_nil }
  its(:concise_output) { should_not be_nil }
end
