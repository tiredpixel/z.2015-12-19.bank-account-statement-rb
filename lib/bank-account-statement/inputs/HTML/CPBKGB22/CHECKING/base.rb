require 'bigdecimal'
require 'date'

require_relative '../../base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module CHECKING

class Base < HTML::Base
  
  def bank
    {
      :id => _bank_account_ids[:bank_id].tr('-', ''),
    }
  end
  
  def account
    {
      :id   => _bank_account_ids[:account_id],
      :type => :CHECKING,
    }
  end
  
  def currency
    :GBP
  end

  def transactions
    _transaction_rows.map { |r|
      a = _transaction_amount(
        r[self.class::TH[:deposit]],
        r[self.class::TH[:withdrawal]]
      )
      
      {
        :posted_at => Date.parse(r[self.class::TH[:date]]),
        :type      => _transaction_type(r[self.class::TH[:desc]], a),
        :name      => r[self.class::TH[:desc]].strip,
        :amount    => a,
      }
    }
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
  
  private
  
  def _clean_str(str)
    str.encode('UTF-8', invalid: :replace, replace: '').strip
  end
  
  def _clean_amount(str)
    BigDecimal(_clean_str(str))
  end

  def _transaction_amount(deposit, withdrawal)
    d = _clean_amount(deposit)
    w = _clean_amount(withdrawal)
    
    w != 0 ? (w * -1) : d
  end
  
  def _transaction_type(name, amount)
    case name
    when /^BROUGHT FORWARD$/
      :OTHER
    when /^COOP ATM/
      :ATM
    when /^LINK /
      :ATM
    when /^TFR /
      :XFER
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
