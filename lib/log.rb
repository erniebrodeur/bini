# It should contain a configuration array.
# Whenever changes are made to the configuration array, updates should be applied.
# it should produce colorized output (either parsed or part of the file format)
# it should wrap logger.
# it should override puts and print to 'capture' output as debug output.
# it will log in UTC by default
# It should have a semi easy to read standard format
# it will have multiple formats available.
module ErnieBrodeur
  class Logger
    def initialize
      @l = ::Logger.new(STDOUT)

      @l.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime.asctime}] [#{severity}]: #{msg}\n"
      end
    end

    def method_missing(sym, *args, &block)
    	@l.send sym, *args, &block
    end
  end

  Log = ErnieBrodeur::Logger.new
end
