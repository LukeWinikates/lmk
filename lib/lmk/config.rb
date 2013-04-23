require 'yaml'
require 'hashie'

module LMK
  class Config
    def self.from_file(path = "#{ENV['HOME']}/.lmkrc")
      new(::YAML.load_file(path))
    end

    def initialize(attributes) 
      attributes.each { |k, v| send("#{k}=".to_sym, v) }
    end
    
    attr_accessor :auth_token, :from, :phone_number, :account_sid
  end
end
