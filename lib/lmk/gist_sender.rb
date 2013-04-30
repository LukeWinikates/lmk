require 'octokit'

module LMK
  class GistSender
    def send(current_result)
      result = client.create_gist options(current_result)
      current_result.html_url = result[:html_url]
      current_result
    end

    def options(current_result)
      { 
        :description => current_result.command, 
        :public => false, 
        :files => {
          "output.txt" => { 
            :content => current_result.output 
          }
        }
      }
    end

    def client
      Octokit::Client.new
    end
  end
end
