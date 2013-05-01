require 'spec_helper'
require 'rspec/mocks'

describe LMK::GistSender do
  let(:fake_result) { { :html_url => "http://example.com/gists/something" } }
  let(:command) { OpenStruct.new(:command => "command string", 
                                 :timestamp => Time.now.utc,
                                 :full_output => "fizzbuzz"  )  }
  let(:sender) { LMK::GistSender.new }

  subject { sender.send(command) }

  describe "#send" do
    before do
      Octokit::Client.any_instance.should_receive(:create_gist) do |arg| 
        arg[:public].should be_false
        arg[:files].should have_key("#{command.timestamp.strftime '%FT%R'}.lmk")
        arg[:files].first[1][:content].should == command.full_output
        arg[:description].should == command.command
        fake_result
      end
    end

    its(:html_url) { should == fake_result[:html_url] }
  end
end
