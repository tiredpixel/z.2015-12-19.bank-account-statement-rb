require 'bigdecimal'
require 'date'

require_relative '../base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module Personal
module CreditCard

class Base < Personal::Base
  
  ACCOUNT_TYPE = :CREDITLINE
  
  def bank
    nil # credit card statement, so account id only
  end
  
end

end
end
end
end
end
end
