module BankAccountStatement
module Outputs

class Base
  
  def self.inherited(subklass)
    @@output_format_klasses ||= []
    @@output_format_klasses << subklass unless subklass.name =~ /Base$/
    super
  end
  
  def self.output_formats
    @@output_format_klasses.map { |k|
      k.name.split('::').drop(2).join('/')
    }.sort
  end
  
  def initialize(data)
    @data = data
  end
  
end

end
end
