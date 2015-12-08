require_relative '../Current/V_2015_03_03'


module BankAccountStatement
module Inputs
module HTML
module CPBKGB22
module Personal
module Savings

# HTML statement parsing for The Co-operative Bank savings accounts.
# 
# This is almost identical to the parsing of current accounts, with versions
# having changed at the same time. To save time, even tests are simply copied.
# If incompatibilities emerge, +Personal::Savings+ can be made more independent.
class V_2015_03_03 < Personal::Current::V_2015_03_03
  
  ACCOUNT_TYPE = :SAVINGS
  
end

end
end
end
end
end
end
