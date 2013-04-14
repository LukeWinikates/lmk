require 'spec_helper'

describe LMK::CommandResultFormatter do
  subject { LMK::CommandResultFormatter.format command }
  let(:command) { OpenStruct.new( :command => 'cat foo', :result => "#! usr/bin/ruby\nputs 'hello world'") }
  
  its(:to_s) do
    should == <<-FORMAT
$$ LMK Shell Command Result $$
% cat foo
#! usr/bin/ruby
puts 'hello world'
FORMAT
  end

end
