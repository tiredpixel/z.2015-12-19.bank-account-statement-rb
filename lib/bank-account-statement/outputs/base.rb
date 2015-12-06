module BankAccountStatement
module Outputs

class Base
  
  def self.inherited(subklass)
    @@format_klasses ||= []
    @@format_klasses << subklass unless subklass.name =~ /Base$/
    super
  end
  
  def self.formats
    Hash[@@format_klasses.map { |k|
      [k.name.split('::').drop(2).join('/'), k]
    }]
  end
  
  def initialize(data)
    @data = data
  end
  
end

end
end
