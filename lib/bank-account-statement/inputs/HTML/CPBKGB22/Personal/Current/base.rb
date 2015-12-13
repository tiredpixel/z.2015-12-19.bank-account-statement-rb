require 'bigdecimal'
require 'date'

require_relative '../base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module Personal
module Current

class Base < Personal::Base
  
  ACCOUNT_TYPE = :CHECKING
  
  def bank
    { :id => _bank_account_ids[:bank_id].tr('-', '') }
  end
  
  def balance
    r = _transaction_rows.last
    
    {
      :ledger => {
        :balanced_at => Date.parse(r[self.class::TH[:date]]),
        :amount      => _clean_amount(r[self.class::TH[:balance]]),
      },
    }
  end
  
end

end
end
end
end
end
end
