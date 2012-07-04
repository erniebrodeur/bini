# it should override puts and print to 'capture' output as debug output.
# It should have a semi easy to read standard format
# it will have multiple formats available.
# it should produce colorized output (either parsed or part of the file format)
require 'logger'

module ErnieBrodeur
  class Logger
    def initialize
    	@options = {}

      @options[:utc] = true
      @options[:level] = ::Logger::WARN
      @options[:override_puts] = false
      @options[:filename] = STDOUT

      create_logger
    end

    def method_missing(sym, *args, &block)
      @l.send sym, *args, &block
      exit if sym == :fatal
    end

    def enable(sym)
      raise 'NoSuchOption' if @options[sym] == nil
      @options[sym] = true

      if sym == :override_puts
      	level ::Logger::DEBUG
      end
    end

    def disable(sym)
      raise 'NoSuchOption' if @options[sym] == nil
      @options[sym] = false
    end

    def level(s)
      level = case s
        when 'fatal' then ::Logger::FATAL
        when 'error' then ::Logger::ERROR
        when 'warn' then ::Logger::WARN
        when 'info' then ::Logger::INFO
        when 'debug' then ::Logger::DEBUG
        else ::Logger::UNKNOWN
      end

    	@options[:level] = level
    	@l.level = level
    end

    def override_puts?
    	return true if @options[:override_puts]
    	false
    end

    def filename(file)
      @options[:filename] = file
      create_logger
    end
    private
    def fmt_time
      if @options[:utc]
        Time.now.getutc
      else
        Time.now
      end
    end

    def create_logger
      @l = ::Logger.new(@options[:filename])
      @l.level = @options[:level]

      @l.formatter = proc do |severity, datetime, progname, msg|
        "[#{fmt_time.asctime}] [#{severity}]: #{msg}\n"
      end

    end
  end

  App.plugins.push 'logging'
  Log = ErnieBrodeur::Logger.new
end

# better way to do this with: Kernel.module_eval def puts ...
module Kernel
  def puts (s)
  	if ErnieBrodeur::Log.override_puts?
    	ErnieBrodeur::Log.info s
    else
    	Kernel::puts s
    end
  end
end
