module LMK
  class Runner
    class Configuration
      attr_accessor :sms_service, :gist_service, :stdout, :shell_service, :stdin

      def initialize(options = defaults)
        @sms_service = options[:sms]
        @gist_service = options[:gist]
        @stdout = options[:stdout]
        @stdin = options[:stdin]
        @shell_service = options[:shell]
      end

      def defaults 
        {
          :stdin => STDIN,
          :stdout => STDOUT,
          :shell => LMK::ShellCommand,
          :gist => LMK::GistSender.new,
          :sms => LMK::TwilioSender.new
        }
      end
    end

    def initialize(configuration = Configuration.new)
      @configuration = configuration
    end

    def send_from_pipe
      from_pipe = @configuration.stdin.read
      console from_pipe
      result = SimpleCommand.new from_pipe
      result = post_to_web(result)
      result = sms(result)
    end

    def run(command)
      return unless validate!
      console("running command `#{command}`")
      result = shell(command)
      result = post_to_web(result)
      result = sms(result)
    end

    def validate! 
      unless @configuration.sms_service.runnable?
        console("Configuration invalid. Run `lmk config` for more info")
        false
      else
        true
      end
    end

    private
    def console(message)
      @configuration.stdout.puts(message)
    end

    def shell(command)
      @configuration.shell_service.exec(command)
    end

    def sms(command)
      @configuration.sms_service.send(command)
    end

    def post_to_web(command)
      @configuration.gist_service.send(command)
    end
  end
end
