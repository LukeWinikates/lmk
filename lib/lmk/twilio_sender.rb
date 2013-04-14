require 'twilio-ruby'

module LMK
  class TwilioSender
    def initialize
      @config = Config.new
      @client = ::Twilio::REST::Client.new(@config.account_sid, @config.auth_token)
    end

    def send_sms(message)
      @client.account.sms.messages.create options.merge(:body => message)
    end

    private
    def options
      {
        :from => @config.from, 
        :to => @config.phone_number, 
      }
    end
  end
end
