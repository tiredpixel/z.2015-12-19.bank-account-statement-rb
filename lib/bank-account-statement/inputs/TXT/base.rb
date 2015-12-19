require_relative '../base'


module BankAccountStatement
module Inputs
module TXT

class Base < Inputs::Base
  
  FILE_EXT = '.txt'.freeze
  
  def initialize(txt)
    @doc   = txt.split("\n").map(&:rstrip)
    @doc_e = @doc.reject(&:empty?)
  end
  
end

end
end
end
