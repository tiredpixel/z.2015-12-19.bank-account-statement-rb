require 'test_helper'


describe "BankAccountStatement::VERSION" do

  it "uses major.minor.patch" do
    ::BankAccountStatement::VERSION.must_match(/\A\d+\.\d+\.\d+\z/)
  end

end
