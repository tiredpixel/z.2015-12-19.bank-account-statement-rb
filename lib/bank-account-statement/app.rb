require 'logger'


module BankAccountStatement

class App
  
  def initialize(opts = {})
    @in = opts[:in].to_s
    
    @in_format = BankAccountStatement::Inputs::Base.formats[opts[:in_format]]
    raise "IN_FORMAT unknown" unless @in_format
    
    @out = opts[:out].to_s
    raise "OUT not directory" unless Dir.exist?(@out)
    
    @out_format = BankAccountStatement::Outputs::Base.formats[opts[:out_format]]
    raise "OUT_FORMAT unknown" unless @out_format
    
    @logger = opts[:logger] || Logger.new(nil)
  end
  
  def run
    Dir.glob(@in) do |f_in|
      f_o_n = File.basename(f_in, @in_format::FILE_EXT) + @out_format::FILE_EXT
      f_out = File.join(@out, f_o_n)
      
      if File.exist?(f_out)
        @logger.warn { "SKIPPED\t#{f_in}" }
      else
        begin
          _convert(f_in, f_out)
          @logger.info { "CONVERTED\t#{f_in}\t#{f_out}" }
        rescue
          @logger.error { "ERRORED\t#{f_in}" }
          raise
        end
      end
    end
  end
  
  private
  
  def _convert(file_in, file_out)
    file_in_c = File.read(file_in)
    in_f = @in_format.new(file_in_c)
    data = in_f.parse
    out_f = @out_format.new(data)
    out_f_c = out_f.generate
    File.write(file_out, out_f_c)
  end
  
end

end
