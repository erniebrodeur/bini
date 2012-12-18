require 'optparse'

module Bini
  # An extension of [OptionParser] that behaves like a hash, with saving, loading, and
  # mashing in other hashs.
  class OptionParser < ::OptionParser
    def initialize
      super
      @options = {}

      on("-V", "--version", "Print version") { |version| @options[:version] = true}
    end

    # Parse out ARGV, includes a catch for returning version, otherwise just calls super.
    def parse!(*argv)
      super

      if Options[:version] && Bini.version
        puts Bini.version
        # don't exit if RSpec is around, we are in a testing environment.
        exit 0 if !Object.constants.include? :RSpec
      end
    end
    # These are the hash like bits.

    # Clear the contents of the builtin Hash.
    def clear
      @options.clear
    end

    # Get results from the builtin in Hash.
    # @param [Symbol,String,nil] key Either a single key or nil for the entire hash.
    # @return [Hash] a hash, empty or otherwise.
    def [](key = nil)
      return @options[key] if key
      return @options if @options.any?
      {}
    end

    # Set a key/value pair in the buildin Hash.
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
  # An automatically created entry point into the OptionParser class.
  Options = Bini::OptionParser.new
end


