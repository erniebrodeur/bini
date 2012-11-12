require 'optparse'

module Bini
  class OptionParser < ::OptionParser
    def initialize
      super
      @options = {}

      on("-V", "--version", "Print version") { |version| @options[:version] = true}
    end

    def parse!
      super

      if Bini.version
        puts Bini.version
        # don't exit if RSpec is around, we are in a testing environment.
        exit 0 if !Object.constants.include? :RSpec
      end
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


