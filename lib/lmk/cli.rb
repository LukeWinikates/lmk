require 'thor'

module LMK
  class CLI < ::Thor
    desc "exec COMMAND", "run a command and get an SMS with its result"
    def exec(*command)
      command = command.join ' '
      Runner.run(command, options)
    end

    desc "config", "read the current twilio config file"
    def config
      Kernel.puts Config.from_file.debug
    end

    desc "debug", "view template output for the given command"
    def debug(*command)
      command = command.join ' '
      cmd = ShellCommand.new(command).tap do |c|
        c.html_url = "http://gist.example.com"
      end
      puts "concise"
      puts cmd.concise_output
      puts "full"
      puts cmd.full_output
    end
  end
end
