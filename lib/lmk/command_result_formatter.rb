module LMK
  class CommandResultFormatter
    def self.format(result)
      "$$ LMK Shell Command Result $$\n% #{result.command}\n#{result.result}\n"
    end
  end
end
