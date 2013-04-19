require 'popen4'

module LMK
  class ShellCommand
    attr_reader :command
    attr_accessor :html_url

    def initialize(command)
      @command = command
      @status = ::POpen4.popen4(command) do |stdout, stderr, stdin, pid| 
        @error = stderr.read 
        @output = stdout.read
      end
    end

    def self.exec(command)
      new(command)
    end

    def success?
      status == 0
    end

    def status
      @status.exitstatus
    end

    def output
      if success?
        @output
      else
        @error
      end
    end
  end
end
