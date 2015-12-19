require_relative 'base'


module BankAccountStatement
module Outputs
module CSV

# CSV 2-column (separate withdrawal and deposit columns) statement generation.
class Column_2 < CSV::Base
  
  HEADER = Hash[{
    :posted_at  => 'Date',
    :name       => 'Description',
    :withdrawal => 'Withdrawals',
    :deposit    => 'Deposits',
  }.map { |k, v| [k, v.freeze] }].freeze
  
  def generate
    _csv_bank_statement
  end
  
  private
  
  def _time(datetime)
    datetime.public_methods
  end
  
  def _amount(amount)
    amount.to_s('F')
  end
  
  def _csv_bank_statement
    ::CSV.generate do |c|
      c << HEADER.values
      @data[:transactions].each do |t|
        t2 = t.merge(_amount_wd(t))
        c << HEADER.keys.map { |e| t2[e] }
      end
    end
  end
  
  def _amount_wd(transaction)
    k, s = transaction[:amount] >= 0 ? [:deposit, 1] : [:withdrawal, -1]
    
    { k => _amount(transaction[:amount] * s) }
  end
  
end

end
end
end
