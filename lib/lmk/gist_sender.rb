require 'octokit'

module LMK
  class GistSender
    def initialize(current_result) 
      @command = current_result
    end

    def self.send(current_result)
      new(current_result).tap(&:send)
    end

    def send
      result = client.create_gist options
      @command.html_url = result[:html_url]
      @command
    end

    def options
      { 
        :description => @command.command, 
        :public => false, 
        :files => {
          "output.txt" => { 
            :content => @command.result 
          }
        }
      }
    end

    def client
      Octokit::Client.new
    end
  end
end
