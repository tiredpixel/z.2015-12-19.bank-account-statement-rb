require 'nokogiri'

require_relative '../base'


module BankAccountStatement
module Inputs
module HTML

class Base < Inputs::Base
  
  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end
  
end

end
end
end
