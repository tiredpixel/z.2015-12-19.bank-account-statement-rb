require 'bigdecimal'
require 'yaml'

require_relative '../../../test_helper'
require_relative '../../../../lib/bank-account-statement/outputs'


{
  BankAccountStatement::Outputs::CSV::Column_2 => [
    'column_2.yaml',
  ],
}.each do |output_klass, fixtures|
  describe output_klass.name do
    fixtures.each do |fixture|
      it fixture.to_s do
        y = File.expand_path("../#{fixture}", __FILE__)
        f = "#{y}.csv"
        
        yc = YAML.load_file(y)
        
        yc[:transactions] = yc[:transactions].map { |t|
          t.merge({ :amount => BigDecimal(t[:amount]) })
        }
        
        yc[:balance][:ledger][:amount] =
            BigDecimal(yc[:balance][:ledger][:amount])
        
        output = output_klass.new(yc)
        op     = output.generate
        
        fc = File.read(f)
        
        op.strip.must_equal fc.strip
      end
    end
  end
end
