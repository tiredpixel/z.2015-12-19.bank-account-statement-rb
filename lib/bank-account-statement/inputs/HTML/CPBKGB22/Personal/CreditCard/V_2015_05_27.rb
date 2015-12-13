require_relative 'base'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module Personal
module CreditCard

# HTML statement parsing for The Co-operative Bank credit card accounts.
# 
# This version is named 2015-05-27 because around that time the statement format
# changed (possibly as early as 2015-03-03 or earlier, when current account
# statements changed, but I don't know). If you experience an error trying to
# process old statements (i.e. statements downloaded before this date), please
# try using a different parser.
# 
# This is similar in format to +Personal::Current::V_2015_03_03+, but contains
# some differences such as not having a balance column, the balance instead
# being provided above the transactions (although note the balance might include
# transactions from a previous statement), and not having a bank id (as account
# id is the full credit card number).
# 
# Note the use of `+` and `-` signs in these statements, which follows liability
# ledger convention, rather than customer point-of-view convention. Thus, `+`
# indicates an increase in liability, with more money owed, and `-` indicates a
# decrease in liability, with some debt paid. This is different to OFX 2.1.1.
class V_2015_05_27 < CreditCard::Base
  
  TH = Hash[{
    :date   => 'Date',
    :desc   => 'Transaction',
    :amount => 'Amount',
  }.map { |k, v| [k, v.freeze] }].freeze
  
  def balance
    balanced_at = @doc.xpath(
        '(//table//table//td[@class="dataRowL"]/table//tr)[1]/td[5]').text
    amount = @doc.xpath(
        '(//table//table//td[@class="dataRowL"]/table//tr)[2]/td[2]').text
    
    {
      :ledger => {
        :balanced_at => Date.parse(balanced_at),
        :amount      => _clean_amount(amount),
      },
    }
  end
  
  private
  
  def _clean_amount(str)
    s = _clean_str(str)
    m = s[-1] == '+' ? -1 : 1 # liability point-of-view; `+` is more debt
    BigDecimal(s) * m
  end
  
  def _bank_account_ids
    t = @doc.xpath(
        '(//table//table//td[@class="dataRowL"]/table//tr)[1]/td[2]').text
    
    { :account_id => t[/\b(\d{16})\b/] }
  end
  
  def _transaction_rows
    header = @doc.xpath('//table[@class="summaryTable"]/thead/tr/th'
        ).map(&:text)
    
    @doc.xpath('//table[@class="summaryTable"]/tbody/tr').map { |r|
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
