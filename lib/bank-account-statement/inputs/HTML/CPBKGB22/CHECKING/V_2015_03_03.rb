require 'bigdecimal'
require 'date'

require_relative '../../base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module CHECKING

# HTML statement parsing for 'The co-operative bank' current accounts.
# 
# This version is named 2015-03-03 because around that time the statement format
# changed. If you experience an error trying to process old statements (i.e.
# statements downloaded before this date), please try using a different parser.
class V_2015_03_03 < HTML::Base
  
  
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
      a = _transaction_amount(r['Money in'], r['Money out'])
      
      {
        :posted_at => Date.parse(r['Date']),
        :type      => _transaction_type(r['Transaction'], a),
        :name      => r['Transaction'].strip,
        :amount    => a,
      }
    }
  end
  
  def balance
    r = _transaction_rows.last
    
    {
      :ledger => {
        :balanced_at => Date.parse(r['Date']),
        :amount      => _clean_amount(r['Balance']),
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
  
  def _bank_account_ids
    t = @doc.xpath('//table//table//table//table//tr').text
    
    {
      :account_id => t[/\b(\d{8})\b/],
      :bank_id    => t[/\b(\d{2}-\d{2}-\d{2})\b/],
    }
  end
  
  def _transaction_rows
    header = @doc.xpath('//table//table//table/thead/tr/th'
        ).map(&:text)
    
    @doc.xpath('//table//table//table/tbody/tr').map { |r|
      Hash[header.zip(r.xpath('td').map(&:text))]
    }
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
