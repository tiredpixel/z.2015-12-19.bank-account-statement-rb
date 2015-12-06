require 'nokogiri'

require_relative 'base'


module BankAccountStatement
module Outputs
module OFX

class V_2_1_1 < OFX::Base
  
  OFX_STRFTIME = '%Y%m%d%H%M%S.%L[%:::z]'.freeze
  
  OFX_HEADER = [
    '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'.freeze,
    '<?OFX OFXHEADER="200" VERSION="211" SECURITY="NONE" OLDFILEUID="NONE" NEWFILEUID="NONE"?>'.freeze,
  ].freeze
  
  def generate
    xml_b = p_xml.to_xml.split("\n").drop(1) # :|
    (OFX_HEADER + xml_b).join("\n")
  end
  
  private
  
  def p_time(datetime)
    datetime.strftime(OFX_STRFTIME)
  end
  
  def p_amount(amount)
    amount.to_s('F')
  end
  
  def p_xml
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
                    x.DTPOSTED p_time(transaction[:posted_at])
                    x.TRNAMT p_amount(transaction[:amount])
                    x.NAME transaction[:name]
                  }
                }
              }
              x.LEDGERBAL {
                x.BALAMT p_amount(@data[:balance][:ledger][:amount])
                x.DTASOF p_time(@data[:balance][:ledger][:balanced_at])
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
