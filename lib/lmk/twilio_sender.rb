module LMK
  class TwilioSender
    def initialize(client = TwilioClientWrapper.new)
      @client = client
    end

    def runnable?
      !!@client && @client.runnable?
    end

    def send(command)
      @client.send command.concise_output
      command
    end
  end
end
