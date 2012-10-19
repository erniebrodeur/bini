require 'optparse'

module Bini
  class OptionParser < ::OptionParser
    def initialize
      super
      @options = {}

      on("-V", "--version", "Print version") { |version| @options[:version] = true}
      on("-p", "--pry", "open a pry shell.") { |pry| @options[:pry] = true}
      if App.plugins.include? 'logging'
        on("-l", "--log-level LEVEL", "Change the log level, default is debug.") { |level| Bini::Log.level level }
        on("--log-file FILE", "What file to output to, default is STDOUT") { |file| Bini::Log.filename file }
      end
    end

    # This will build an on/off option with a default value set to false.
    def bool_on(word, description = "")
      Options[word.to_sym] = false
      on "-#{word.chars.first}", "--[no]#{word}", description  do |o|
        Options[word.to_sym] == o
      end
    end

    def parse!
      @banner = Bini::App.banner
      super

      if @options[:version]
        puts Bini::App.version
        exit 0
      end

      # we need to mash in our config array.  To do this we want to make config
      # options that don't overwrite cli options.
      if App.plugins.include? 'config'
        Config.each do |k,v|
          @options[k] = v if !@options[k]
        end
      end
    end

    def on_pry
      if @options[:pry]
        require 'pry'
        binding.pry
      end
    end

    def [](k = nil)
      return @options[k] if k
      return @options if @options.any?
      nil
    end

    def []=(k,v)
      @options[k] = v
    end
  end

  App.plugins.push "optparser"
  Options = OptionParser.new
end
