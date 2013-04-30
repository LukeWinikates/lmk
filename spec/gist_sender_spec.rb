require 'spec_helper'
require 'rspec/mocks'

describe LMK::GistSender do
  before do
    Octokit::Client.any_instance.stub(:create_gist) { fake_result }
  end

  let(:fake_result) { {:html_url => "http://example.com/gists/something"} }
  let(:input) { OpenStruct.new(:command => "command string", :result => "result_string" )  }
  let(:sender) { LMK::GistSender.new }
  subject { sender.send(input) }

  describe "#send" do
    # it "calls the Octokit API with the right arguments" do
    #  Octokit::Client.any_instance.should_receive(:create_gist) do |arg| 
    #    arg[:public].should be_false
    #  end
    #  subject
    #end
    its(:html_url) { should == fake_result[:html_url] }
  end
end
