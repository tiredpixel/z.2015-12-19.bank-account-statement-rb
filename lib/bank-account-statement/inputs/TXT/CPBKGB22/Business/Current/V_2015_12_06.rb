require 'bigdecimal'

require_relative 'base'


module BankAccountStatement
module Inputs
module TXT
module CPBKGB22
module Business
module Current

# TXT statement parsing for The Co-operative Bank business current accounts.
class V_2015_12_06 < Current::Base
  
  TH = Hash[{
    :date       => 'DATE',
    :desc       => 'DESCRIPTION',
    :withdrawal => 'WITHDRAWALS',
    :deposit    => 'DEPOSITS',
    :balance    => 'BALANCE',
  }.map { |k, v| [k, v.freeze] }].freeze
  
  private
  
  def _clean_amount(str)
    a = str.tr(',', '')
    BigDecimal(a)
  end
  
  def _bank_account_ids
    @doc_e[0].match(/\b(?<bank_id>\d{6})(?<account_id>\d{8})\d{2}\b/)
  end
  
  def _transaction_rows
    hr = @doc_e[3]
    
    cs = _columns(hr)
    
    body_rs = @doc_e[4..-1]
    
    body_rs.map { |r|
      Hash[TH.keys.map { |e| [e, r[cs[e]]] }]
    }
  end
  
  def _columns(header_row)
    hi = Hash[TH.map { |k, v|
      i = header_row.index(v)
      [k, i...(i + v.length)]
    }]
    
    cs = {}
    cs[:date]       = 0...10
    cs[:desc]       = (cs[:date].last)...(hi[:withdrawal].first)
    cs[:withdrawal] = (cs[:desc].last)...(hi[:withdrawal].last)
    cs[:deposit]    = (cs[:withdrawal].last)...(hi[:deposit].last)
    cs[:balance]    = (cs[:deposit].last)...(hi[:balance].last)
    
    cs
  end
  
end

end
end
end
end
end
end
