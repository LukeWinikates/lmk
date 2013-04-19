module LMK
  class Runner
    class Configuration
      attr_accessor :sms_service, :gist_service, :console_service, :shell_service

      def initialize
        @sms_service = LMK::TwilioSender
        @gist_service = LMK::GistSender
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

    def run(command, options)
      console("running command `#{command}`")
      result = shell(command)
      #puts result.result
      #TwilioSender.new.send_sms CommandResultFormatter.format(result) unless options.t?
      console(result.output)
    end
  end
end
