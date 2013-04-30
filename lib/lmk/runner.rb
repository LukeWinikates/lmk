module LMK
  class Runner
    class Configuration
      attr_accessor :sms_service, :gist_service, :console_service, :shell_service

      def initialize
        @sms_service = LMK::TwilioSender.new
        @gist_service = LMK::GistSender.new
        @console_service = Kernel
        @shell_service = LMK::ShellCommand
      end
    end

    def self.configure
      yield self.configuration
    end

    def self.configuration
      @@default_configuration ||= Configuration.new
    end

    def self.run(command, options)
      new.run(command, options)
    end

    def initialize(configuration = Runner.configuration)
      @configuration = configuration
    end

    def console(message)
      @configuration.console_service.puts(message)
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

    def run(command, options)
      return unless validate!
      console("running command `#{command}`")
      result = shell(command)
      result = post_to_web(result)
      result = sms(result)
      console(result.output)
    end

    def validate! 
      unless @configuration.sms_service.runnable?
        console("Configuration invalid. Run `lmk config` for more info")
        false
      else
        true
      end
    end
  end
end
