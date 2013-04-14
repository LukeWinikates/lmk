require 'popen4'

module LMK
  class CommandRunner
    def initialize(command)
      @command = command
      @status = ::POpen4.popen4(command) do |stdout, stderr, stdin, pid| 
        @error = stderr.read 
        @output = stdout.read
      end
    end

    def success?
      status == 0
    end

    def status
      @status.exitstatus
    end

    def result
      if success?
        @output
      else
        @error
      end
    end
  end
end
