require 'thor'

module LMK
  class CLI < ::Thor
    def self.runner=(runner)
      @runner = runner
    end

    def self.runner
      @runner ||= Runner.new
    end

    default_task :send_from_pipe

    desc "exec COMMAND", "run a command and get an SMS with its result"
    def exec(*command)
      command = command.join ' '
      self.class.runner.run(command)
    end

    desc "config", "read and validate the current twilio config file"
    def config
      Kernel.puts Config.from_file.debug
    end

    desc "debug COMMAND", "view template output for the given command"
    def debug(*command)
      command = command.join ' '
      cmd = ShellCommand.new(command).tap do |c|
        c.html_url = "http://gist.example.com"
      end
      puts "concise"
      puts cmd.concise_output
      puts "\n\nfull"
      puts cmd.full_output
    end

    desc "send_from_pipe", "begin reading from STDIN and send an SMS once the pipe closes"
    def send_from_pipe
      self.class.runner.send_from_pipe
    end
  end
end
