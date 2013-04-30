require 'twilio-ruby'

module LMK
  class TwilioClientWrapper
    def initialize(config = Config.from_file)
      @config = config
      @client = ::Twilio::REST::Client.new(@config.account_sid, @config.auth_token) if runnable?
    end

    def runnable?
      @config.valid?
    end

    def send(message)
      @client.account.sms.messages.create options.merge(:body => message)
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
