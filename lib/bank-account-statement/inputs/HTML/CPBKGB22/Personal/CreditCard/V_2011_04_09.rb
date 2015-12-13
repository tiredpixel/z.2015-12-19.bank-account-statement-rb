require_relative 'base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module Personal
module CreditCard

# HTML statement parsing for The Co-operative Bank credit card accounts.
# 
# This version is named 2011-04-09 because for quite a while after that time,
# statements were made available in the same format (also on that date, and
# perhaps before?). Note, however, that the statement format changed some time
# later, for which a different parser should be used. If you experience an error
# trying to process a statement downloaded recently, then this is probably why.
# 
# This is similar in format to +Personal::Current::V_2011_05_07+, but contains
# some differences such as not having a balance column, the balance instead
# being provided above the transactions (although note the balance might include
# transactions from a previous statement), and not having a bank id (as account
# id is the full credit card number).
class V_2011_04_09 < CreditCard::Base
  
  TH = Hash[{
    :date       => 'Date',
    :desc       => 'Transaction',
    :deposit    => 'Deposits',
    :withdrawal => 'Withdrawals',
  }.map { |k, v| [k, v.freeze] }].freeze
  
  def balance
    balanced_at = @doc.xpath('(//table//table//table//table//tr)[1]/td[2]').text
    amount      = @doc.xpath('(//table//table//table//table//tr)[3]/td[2]').text
    
    {
      :ledger => {
        :balanced_at => Date.parse(balanced_at),
        :amount      => _clean_amount(amount),
      },
    }
  end
  
  private
  
  def _bank_account_ids
    t = @doc.xpath('//table//table//table//td[@class="field"]/h4').first.text
    
    { :account_id => t[/\b(\d{16})\b/] }
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
end
