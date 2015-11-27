module BankAccountStatement
module Inputs

class Base
  
  def parse
    {
      :bank         => bank,
      :account      => account,
      :currency     => currency,
      :transactions => transactions,
      :balance      => balance,
    }
  end
  
end

end
end
