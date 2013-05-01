require 'popen4'
require 'erb'

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

    def get_binding
      binding
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

    def concise_output
      preliminary_result = concise_template.result get_binding
      leeway = 140 - preliminary_result.size
      if leeway > 30
        preliminary_result << "\n#{output[0...leeway-5]}..."
      end
      preliminary_result
    end

    def full_output
      full_template.result get_binding
    end 

    def full_template
      ERB.new %q{
%%% LMK Command Result: %%%
> <%= command %>
<% if success? %>succeeded 
<% else %> failed (<%=status%>)<% end %>
full output:
----------------------------
<%=output%>
      }
    end

    def concise_template
      ERB.new %q{
%%% LMK Command Result: %%%
> <%= command %>
<% if success? %>succeeded 
<% else %> failed (<%=status%>)<% end %>
<% if html_url %> full result @ <%= html_url %><% end %>
}
    end
  end
end
