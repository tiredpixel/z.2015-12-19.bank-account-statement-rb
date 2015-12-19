require_relative '../../base'


module BankAccountStatement
module Inputs
module TXT
module CPBKGB22
module Business

class Base < TXT::Base
  
  def account
    {
      :id   => _bank_account_ids[:account_id],
      :type => self.class::ACCOUNT_TYPE,
    }
  end
  
  def currency
    :GBP
  end
  
  def transactions
    _transaction_rows.map { |r|
      begin
        posted_at = Date.parse(r[:date])
      rescue ArgumentError
        next # annotation line
      end
      
      a= _transaction_amount(r[:deposit], r[:withdrawal])
      
      {
        :posted_at => posted_at,
        :type      => _transaction_type(r[:desc], a),
        :name      => r[:desc].strip,
        :amount    => a,
      }
    }.compact
  end
  
  private
  
  def _clean_str(str)
    str.strip
  end
  
  def _transaction_amount(deposit, withdrawal)
    d = _clean_amount(deposit)
    w = _clean_amount(withdrawal)
    
    w != 0 ? (w * -1) : d
  end
  
  def _transaction_type(name, amount)
    case name
    when /^DD /
      :DIRECTDEBIT
    when /^SO /
      :REPEATPMT
    else
      amount >= 0 ? :CREDIT : :DEBIT
    end
  end
  
end

end
end
end
end
end
