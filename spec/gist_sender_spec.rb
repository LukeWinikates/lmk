require 'spec_helper'
require 'rspec/mocks'

describe LMK::GistSender do
  before do
    Octokit::Client.any_instance.stub(:create_gist) { fake_result }
  end

  let(:fake_result) { {:html_url => "http://example.com/gists/something"} }
  let(:input) { OpenStruct.new(:command => "command string", :result => "result_string" )  }
  let(:sender) { LMK::GistSender.new(input) }

  describe "#send" do
    it "returns a result decorated with a full_result_url" do
      sender.send.html_url.should == fake_result[:html_url]
    end
  end
end
