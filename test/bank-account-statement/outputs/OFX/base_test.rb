require_relative '../../../test_helper'
require_relative '../../../../lib/bank-account-statement/outputs/OFX/V_2_1_1'


{
  BankAccountStatement::Outputs::OFX::V_2_1_1 => [
    '2.1.1.yaml',
  ],
}.each do |output_klass, fixtures|
  describe output_klass.name do
    fixtures.each do |fixture|
      it fixture.to_s do
        y = File.expand_path("../#{fixture}", __FILE__)
        f = "#{y}.ofx"
        
        yc = YAML.load_file(y)
        
        output = output_klass.new(yc)
        op     = output.generate
        
        fc = File.read(f)
        
        op.must_equal fc.strip
      end
    end
  end
end
