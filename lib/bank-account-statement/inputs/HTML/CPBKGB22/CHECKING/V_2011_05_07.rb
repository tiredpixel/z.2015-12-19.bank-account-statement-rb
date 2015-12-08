require_relative 'base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module CHECKING

# HTML statement parsing for The Co-operative Bank current accounts.
# 
# This version is named 2011-05-07 because for quite a while after that time,
# statements were made available in the same format (also on that date, and
# perhaps before?). Note, however, that the statement format changed some time
# around 2015-03-03, for which a different parser should be used. If you
# experience an error trying to process a recent statement (or rather, a
# statement downloaded recently, as it could be an old statement), then this is
# probably why.
class V_2011_05_07 < CHECKING::Base
  
  TH = Hash[{
    :date       => 'Date',
    :desc       => 'Transaction',
    :deposit    => 'Deposits',
    :withdrawal => 'Withdrawals',
    :balance    => 'Balance',
  }.map { |k, v| [k, v.freeze] }].freeze
  
  private
  
  def _bank_account_ids
    t = @doc.xpath('//table//table//table//td[@class="field"]/h4').first.text
    t.match(/\D(?<bank_id>\d{2}-\d{2}-\d{2})\D+(?<account_id>\d{8})\D/)
  end
  
  def _transaction_rows
    header = @doc.xpath('//table//table//table//table//table/thead/tr/th'
        ).map(&:text)
    
    @doc.xpath('//table//table//table//table//table/tbody/tr').map { |r|
      Hash[header.zip(r.xpath('td').map(&:text))]
    }
  end
  
end

end
end
end
end
end
