require 'bigdecimal'
require 'date'

require_relative '../../base.rb'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module CHECKING

class V_2011_05_07 < HTML::Base
  
  def parse
    {
      'bank'         => {
        'id' => bank_id,
      },
      'account'      => {
        'id'   => account_id,
        'type' => account_type,
      },
      'currency'     => currency,
      'transactions' => transactions,
      'balance'      => balance,
    }
  end
  
  def bank_id
    p_bank_account_ids[:bank_id].tr('-', '')
  end
  
  def account_id
    p_bank_account_ids[:account_id]
  end
  
  def account_type
    'CHECKING'
  end
  
  def currency
    'GBP'
  end
  
  def transactions
    p_transaction_rows.map { |r|
      a = p_transaction_amount(r['Deposits'], r['Withdrawals'])
      
      {
        'posted_at' => Date.parse(r['Date']),
        'type'      => p_transaction_type(r['Transaction'], a),
        'name'      => r['Transaction'].strip,
        'amount'    => a,
      }
    }
  end
  
  def balance
    r = p_transaction_rows.last
    
    {
      'ledger' => {
        'balanced_at' => Date.parse(r['Date']),
        'amount'      => p_clean_amount(r['Balance']),
      },
    }
  end
  
  private
  
  def p_clean_str(str)
    str.encode('UTF-8', invalid: :replace, replace: '').strip
  end
  
  def p_clean_amount(str)
    BigDecimal(p_clean_str(str))
  end
  
  def p_bank_account_ids
    t = @doc.xpath('//table//table//table//td[@class="field"]/h4').first.text
    t.match(/\D(?<bank_id>\d{2}-\d{2}-\d{2})\D+(?<account_id>\d{8})\D/)
  end
  
  def p_transaction_rows
    header = @doc.xpath('//table//table//table//table//table/thead/tr/th'
        ).map(&:text)
    
    @doc.xpath('//table//table//table//table//table/tbody/tr').map { |r|
      Hash[header.zip(r.xpath('td').map(&:text))]
    }
  end
  
  def p_transaction_amount(deposit, withdrawal)
    d = p_clean_amount(deposit)
    w = p_clean_amount(withdrawal)
    
    w != 0 ? (w * -1) : d
  end
  
  def p_transaction_type(name, amount)
    case name
    when /^BROUGHT FORWARD$/
      'OTHER'
    when /^COOP ATM/
      'ATM'
    when /^LINK /
      'ATM'
    when /^TFR /
      'XFER'
    else
      amount >= 0 ? 'CREDIT' : 'DEBIT'
    end
  end
  
end

end
end
end
end
end
