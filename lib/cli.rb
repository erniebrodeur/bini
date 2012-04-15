# This library is to reduce the amount of effort I need to build a binary with option parsing
# and sensable defaults.  It is not intended to be convient for anybody but me, their
# are a host of good @options out there if you want cli tools.
require 'optparse'

class OptBlob
  def initialize
    @options = {}

    @parser = OptionParser.new do |opts|
      opts.banner = Banner

      opts.on("-v", "--[no-]verbose", "Run verbosely") { |verbose| @options[:verbose] = verbose }
      opts.on("-V", "--version", "Print version") { |version| @options[:version] = version}
      opts.on("-p", "--pry", "open a pry shell.") { |pry| @options[:pry] = true}
    end
  end

  #TODO figure out a more dynamic way to include the parser and hash table.
  def []=(key, value)
    @options[key] = value
  end

  def [](key)
    @options[key]
  end

  # This will build an on/off option with a default value set to false.
  def bool_on(word, description = "")
  	Options[word.to_sym] = false
  	@parser.on "-#{word.chars.first}", "--[no]#{word}", description  do |o|
  		Options[word.to_sym] == o
  	end
  end

  # This is the parser value on lifted up.
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

  def on_pry
    if @options[:pry]
      require 'pry'
      binding.pry
    end
  end
end

Options = OptBlob.new
