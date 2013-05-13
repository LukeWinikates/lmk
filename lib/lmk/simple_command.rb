module LMK
  class SimpleCommand < CommandBase
    attr_reader :output

    def initialize(piped_message)
      @output = piped_message
      @timestamp = Time.now
      @command = "(piped from shell)"
    end
  end
end


# ducktype: concise_output, command, timestamp, full_output, html_url
