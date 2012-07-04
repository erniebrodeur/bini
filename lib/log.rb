# it should override puts and print to 'capture' output as debug output.
# It should have a semi easy to read standard format
# it will have multiple formats available.
# it should produce colorized output (either parsed or part of the file format)

module ErnieBrodeur

  class Logger
  	attr_reader :options

    def initialize(*args)
      @options = {}
      @options[:utc] = true
      @options[:level] = ::Logger::WARN

      @l = ::Logger.new(STDOUT)
      @l.level = @options[:level]

      @l.formatter = proc do |severity, datetime, progname, msg|
        "[#{fmt_time.asctime}] [#{severity}]: #{msg}\n"
      end
    end

    def method_missing(sym, *args, &block)
      @l.send sym, *args, &block
      exit if sym == :fatal
    end

    def enable(sym)
    	raise 'NoSuchOption' if @options[sym] == nil
    	@options[sym] = true
    end

    def disable(sym)
    	raise 'NoSuchOption' if @options[sym] == nil
    	@options[sym] = false
    end

    private
    def fmt_time
      if @options[:utc]
        Time.now.getutc
      else
        Time.now
      end
    end
  end

  Log = ErnieBrodeur::Logger.new
end
