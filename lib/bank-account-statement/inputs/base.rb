module BankAccountStatement
module Inputs

class Base
  
  def self.inherited(subklass)
    @@input_format_klasses ||= []
    @@input_format_klasses << subklass unless subklass.name =~ /Base$/
    super
  end
  
  def self.input_formats
    @@input_format_klasses.map { |k|
      k.name.split('::').drop(2).join('/')
    }.sort
  end
  
  def parse
    {
      :bank         => bank,
      :account      => account,
      :currency     => currency,
      :transactions => transactions,
      :balance      => balance,
    }
  end
  
end

end
end
