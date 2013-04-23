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
      Config.new.raw
    end
  end
end
