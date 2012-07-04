# It should contain a configuration array.
# Whenever changes are made to the configuration array, updates should be applied.
# it should override puts and print to 'capture' output as debug output.
# It should have a semi easy to read standard format
# it will have multiple formats available.
# it should produce colorized output (either parsed or part of the file format)

module ErnieBrodeur

  class Logger
    def initialize(*args)

      @l = ::Logger.new(STDOUT)

      @l.formatter = proc do |severity, datetime, progname, msg|
        "[#{datetime.getutc.asctime}] [#{severity}]: #{msg}\n"
      end
    end

    def method_missing(sym, *args, &block)
    	@l.send sym, *args, &block
    	exit if sym == :fatal
    end

    def enable
    end

    def disable
    end

  end

  Log = ErnieBrodeur::Logger.new
end
