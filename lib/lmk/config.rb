module LMK
  class Config
    def initialize(file_path = "#{ENV['HOME']}/.lmkrc")
      @file_path = file_path
    end

    def raw
      File.read @file_path
    end
    
    def auth_token
      yml["auth_token"]
    end
    
    def from
      yml["from"]
    end

    def phone_number
      yml["phone_number"]
    end

    def account_sid
      yml["account_sid"]
    end

    private
    def yml
      @yml ||= YAML.load_file(@file_path)
    end
  end
end
