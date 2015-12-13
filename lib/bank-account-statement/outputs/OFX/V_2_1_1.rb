require 'nokogiri'

require_relative 'base'


module BankAccountStatement
module Outputs
module OFX

# OFX 2.1.1 statement generation.
class V_2_1_1 < OFX::Base
  
  OFX_STRFTIME = '%Y%m%d%H%M%S.%L[%:::z]'.freeze
  
  OFX_HEADER = [
    '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'.freeze,
    '<?OFX OFXHEADER="200" VERSION="211" SECURITY="NONE" OLDFILEUID="NONE" NEWFILEUID="NONE"?>'.freeze,
  ].freeze
  
  def generate
    _xml = case @data[:account][:type]
    when :CREDITLINE
      _xml_credit_card
    else
      _xml_bank_statement
    end
    
    xml_b = _xml.to_xml.split("\n").drop(1) # :|
    (OFX_HEADER + xml_b).join("\n")
  end
  
  private
  
  def _time(datetime)
    datetime.strftime(OFX_STRFTIME)
  end
  
  def _amount(amount)
    amount.to_s('F')
  end
  
  def _xml_bank_statement
    Nokogiri::XML::Builder.new { |x|
      x.OFX {
        x.BANKMSGSRSV1 {
          x.STMTTRNRS {
            x.STMTRS {
              x.CURDEF @data[:currency]
              x.BANKACCTFROM {
                x.BANKID @data[:bank][:id]
                x.ACCTID @data[:account][:id]
                x.ACCTTYPE @data[:account][:type]
              }
              x.BANKTRANLIST {
                @data[:transactions].each { |transaction|
                  x.STMTTRN {
                    x.TRNTYPE transaction[:type]
                    x.DTPOSTED _time(transaction[:posted_at])
                    x.TRNAMT _amount(transaction[:amount])
                    x.NAME transaction[:name]
                  }
                }
              }
              x.LEDGERBAL {
                x.BALAMT _amount(@data[:balance][:ledger][:amount])
                x.DTASOF _time(@data[:balance][:ledger][:balanced_at])
              }
            }
          }
        }
      }
    }
  end
  
  def _xml_credit_card
    Nokogiri::XML::Builder.new { |x|
      x.OFX {
        x.BANKMSGSRSV1 {
          x.CCSTMTTRNRS {
            x.CCSTMTRS {
              x.CURDEF @data[:currency]
              x.CCACCTFROM {
                x.ACCTID @data[:account][:id]
              }
              x.BANKTRANLIST {
                @data[:transactions].each { |transaction|
                  x.STMTTRN {
                    x.TRNTYPE transaction[:type]
                    x.DTPOSTED _time(transaction[:posted_at])
                    x.TRNAMT _amount(transaction[:amount])
                    x.NAME transaction[:name]
                  }
                }
              }
              x.LEDGERBAL {
                x.BALAMT _amount(@data[:balance][:ledger][:amount])
                x.DTASOF _time(@data[:balance][:ledger][:balanced_at])
              }
            }
          }
        }
      }
    }
  end

end

end
end
end
