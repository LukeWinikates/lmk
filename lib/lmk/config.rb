require 'yaml'
require 'hashie'

module LMK
  class Config
    def self.default_path
      "#{ENV['HOME']}/.lmkrc"
    end

    def self.from_file(path = default_path)
      attrs = ::YAML.load_file(path) if File.exists?(path)
      new(attrs, path)
    end

    def initialize(attributes, file = nil) 
      (attributes || {}).each do |k, v|
        setter = "#{k}=".to_sym
        send(setter, v) if respond_to?(setter)
      end
      @file = file
    end

    def valid? 
      required_attributes.map { |attr| send(attr) }.all?
    end

    def required_attributes
      [:auth_token, :from, :phone_number, :account_sid]
    end

    def missing_values
      required_attributes.select { |method| send(method).nil? }
    end

    def debug
      <<-RESULT
LMK Configuration #{valid? ? 'valid' : 'invalid'} 
#{'Config file missing, create ' + @file  + ' with required values.' if @file && !File.exists?(@file) }
missing values: #{valid? ? 'none' : missing_values }
#{raw}
      RESULT
    end

    def raw
      instance_variables.map do |ivar|
        "#{ivar.to_s.gsub("@", "")}: #{instance_variable_get ivar}"
      end.join "\n"
    end
    
    attr_accessor :auth_token, :from, :phone_number, :account_sid
  end
end
