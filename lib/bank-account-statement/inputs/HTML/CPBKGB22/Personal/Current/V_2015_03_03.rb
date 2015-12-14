require_relative 'base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module Personal
module Current

# HTML statement parsing for The Co-operative Bank current accounts.
# 
# This version is named 2015-03-03 because around that time the statement format
# changed. If you experience an error trying to process old statements (i.e.
# statements downloaded before this date), please try using a different parser.
class V_2015_03_03 < Current::Base
  
  TH = Hash[{
    :date       => 'Date',
    :desc       => 'Transaction',
    :deposit    => 'Money in',
    :withdrawal => 'Money out',
    :balance    => 'Balance',
  }.map { |k, v| [k, v.freeze] }].freeze
  
  private
  
  def _clean_amount(str)
    s = _clean_str(str)
    m = s[-1] == '-' ? -1 : 1
    BigDecimal(s) * m
  end
  
  def _bank_account_ids
    t = @doc.xpath('//table//table//table//table//tr').text
    
    {
      :account_id => t[/\b(\d{8})\b/],
      :bank_id    => t[/\b(\d{2}-\d{2}-\d{2})\b/],
    }
  end
  
  def _transaction_rows
    header = @doc.xpath('//table//table//table/thead/tr/th').map(&:text)
    
    @doc.xpath('//table//table//table/tbody/tr').map { |r|
      Hash[header.zip(r.xpath('td').map(&:text))]
    }
  end
  
end

end
end
end
end
end
end
