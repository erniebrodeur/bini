require 'optparse'

module Bini
  class OptionParser < ::OptionParser
    def initialize
      super
      @options = {}

      on("-V", "--version", "Print version") { |version| @options[:version] = true}
      if App.plugins.include? 'logging'
        on("-l", "--log-level LEVEL", "Change the log level, default is debug.") { |level| Bini::Log.level level }
        on("--log-file FILE", "What file to output to, default is STDOUT") { |file| Bini::Log.filename file }
      end
    end

    def parse!
      @banner = Bini::App.banner
      super

      if @options[:version]
        puts Bini::App.version
        exit 0
      end

      mash Bini.config if Bini.config
    end

    # These are the hash like bits.

    def clear
      @options.clear
    end

    def [](k = nil)
      return @options[k] if k
      return @options if @options.any?
      {}
    end

    def []=(k,v)
      @options[k] = v
    end

    # merge takes in a set of values and overwrites the previous values.
    # mash does this in reverse.
    def mash(h)
      h.merge! @options
      @options.clear
      h.each {|k,v| self[k] = v}
    end
  end
  Options = OptionParser.new
end

