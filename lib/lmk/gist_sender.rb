require 'octokit'

module LMK
  class GistSender
    def send(commmand)
      result = client.create_gist options(commmand)
      commmand.html_url = result[:html_url]
      commmand
    end

    def options(command)
      { 
        :description => command.command, 
        :public => false, 
        :files => {
          "#{command.timestamp}.lmk" => { 
            :content => command.full_output 
          }
        }
      }
    end

    def client
      Octokit::Client.new
    end
  end
end
