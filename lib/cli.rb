# This library is to reduce the amount of effort I need to build a binary with option parsing
# and sensable defaults.  It is not intended to be convient for anybody but me, their
# are a host of good @options out there if you want cli tools.

require 'optparse'
require 'ostruct'

class OptBlob
  def initialize
    @options = {}
    @options[:verbose] = false
    @options[:version] = false

    @parser = OptionParser.new do |opts|
      opts.banner = Banner

      opts.on("-v", "--[no-]verbose", "Run verbosely") { |verbose| @options[:verbose] = v }
      opts.on("-V", "--version", "Print version") { |version| @options[:version] = version}
    end
  end

  #TODO figure out a more dynamic way to include the parser and hash table.
  def []=(item)
    @options[item]
  end

  def [](item)
    @options[item]
  end

  def on(*opts, &block)
  	@parser.on(*opts, &block)
  end

  def on_tail(*opts, &block)
  	@parser.on(*opts, &block)
  end

  def on_head(*opts, &block)
  	@parser.on(*opts, &block)
  end

 	def parse!
 		@parser.parse!

    if @options[:version]
      puts Version
      exit 0
    end
 	end
end

Options = OptBlob.new
