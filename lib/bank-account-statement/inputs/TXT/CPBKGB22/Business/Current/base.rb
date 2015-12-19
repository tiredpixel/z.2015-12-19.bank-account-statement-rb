require 'date'

require_relative '../base'


module BankAccountStatement
module Inputs
module TXT
module CPBKGB22
module Business
module Current

class Base < Business::Base
  
  ACCOUNT_TYPE = :CHECKING
  
  def bank
    { :id => _bank_account_ids[:bank_id] }
  end
  
  def balance
    r = _transaction_rows.last
    
    {
      :ledger => {
        :balanced_at => Date.parse(r[:date]),
        :amount      => _clean_amount(r[:balance]),
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
