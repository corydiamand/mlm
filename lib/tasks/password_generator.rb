require 'securerandom'
require 'csv'

class ClientList

  attr_accessor :filehandle, :output

  def initialize(path_to_file)
    begin
      @filehandle = CSV.open(path_to_file, 'r+')
      @output = CSV.open('../assets/converted_user_names.csv', 'w')
      add_passwords
    rescue
      raise "Invalid filename or path!"
    end
  end

  def add_passwords
    @filehandle.each do |line|
      line << SecureRandom.hex[0..5]
      @output << line
    end
  end
end

