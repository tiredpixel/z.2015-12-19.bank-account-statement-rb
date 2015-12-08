require 'bigdecimal'
require 'yaml'

require_relative '../../../test_helper'
require_relative '../../../../lib/bank-account-statement/inputs'


{
  BankAccountStatement::Inputs::HTML::CPBKGB22::Personal::Current::V_2011_05_07 => [
    'HTML/CPBKGB22/Personal/Current/2011-05-07.html',
  ],
  BankAccountStatement::Inputs::HTML::CPBKGB22::Personal::Current::V_2015_03_03 => [
    'HTML/CPBKGB22/Personal/Current/2015-03-03.html',
  ],
}.each do |input_klass, fixtures|
  describe input_klass.name do
    fixtures.each do |fixture|
      it fixture.to_s do
        f = File.expand_path("../../#{fixture}", __FILE__)
        y = "#{f}.yaml"
        
        fc = File.read(f)
        yc = YAML.load_file(y)
        
        input = input_klass.new(fc)
        
        ip = input.parse
        
        ip[:transactions].each_with_index do |transaction, i|
          transaction.must_equal yc[:transactions][i].merge({
            :amount => BigDecimal(transaction[:amount]),
          })
        end
        
        if yc[:balance]
          if yc[:balance][:ledger]
            if x = yc[:balance][:ledger][:amount]
              yc[:balance][:ledger][:amount] = BigDecimal(x)
            end
          end
        end
        
        ip.reject { |k, v|
          k == :transactions
        }.must_equal yc.reject { |k, v|
          k == :transactions
        }
      end
    end
  end
end
