require 'popen4'
require 'erb'

module LMK
  class ShellCommand < CommandBase
    attr_accessor :html_url

    def initialize(command, kernel = Kernel)
      @kernel = kernel
      @timestamp = Time.now
      @command = command
      @status = ::POpen4.popen4(command) do |stdout, stderr, stdin, pid| 
        @error = read_while_streaming(stderr)
        @output = read_while_streaming(stdout)
      end
    end

    def read_while_streaming(io)
      full = ""
      until io.eof? do
        line = io.readline
        @kernel.puts(line)
        full << line
      end
      full
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
      success? ? @output : @error
    end

    def status_header 
      ERB.new %q{
<% if success? %>succeeded 
<% else %>failed (<%=status%>)<% end %>}
    end
  end
end
