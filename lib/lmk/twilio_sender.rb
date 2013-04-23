require 'twilio-ruby'

module LMK
  class TwilioSender
    def initialize
      @config = Config.from_file
      @client = ::Twilio::REST::Client.new(@config.account_sid, @config.auth_token)
    end

    def send(command)
      @client.account.sms.messages.create options.merge(:body => command.output)
      command
    end

    def self.send(message)
      new.send(message)
    end

    private
    def options
      {
        :from => @config.from, 
        :to => @config.phone_number 
      }
    end
  end
end
