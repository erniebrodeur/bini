# Some requires, they don't fit elsewhere.
require 'yajl'
require 'sys/proctable'
module Bini

  class Application
    attr_accessor :version
    attr_accessor :banner
    attr_accessor :long_description
    attr_accessor :plugins

    # return the name of the app, for now this is just the cmd ran, later it will be
    # something generated but more unique.
    def name
      $0.split("/").last
    end

    def cache_dir
      "#{Dir.home}/.cache/bini/#{App.name}/"
    end

    def config_dir
      "#{Dir.home}/.config/bini/#{App.name}/"
    end

    def pids
      a = Sys::ProcTable.ps.select{|x| x.cmdline =~ /.*#{App.name}.*-[dD].*/}.map {|x| x.pid}
      a.delete $$
      return a if a.any?
      nil
    end

    def initialize
      @version = '0.0.0'
      @banner  = 'A bin snippet by Ernie Brodeur that does . . . something.'
      @long_description = ''
      @plugins = []
    end

    def daemonize(*params, &block)
      if params[0] && !params[0][:multiple_pids] && pids
        puts_or_log :info, "#{App.name} appears to be running (#{pids}), only one allowed, exiting."
        exit
      end
      puts_or_log :info, "Forking to background."

      Process.daemon
      block.call
    end

    def kill_daemon
      if !pids
        puts_or_log :fatal, "No pids found, exiting."
      end

      pids.each do |p|
        puts_or_log :info, "Killing #{p}"
        `kill -TERM #{p}`
      end
    end
    private
    def puts_or_log(l, s)
      if App.plugins.include? 'logging'
        Log.send l, s
      else
        puts s
        exit if l.to_sym == :fatal
      end
    end
  end

  App = Application.new

  # Try to load a helper, 'rescue' if it isn't there.
  begin
    require "bini/helpers/#{App.name}.rb"
  rescue LoadError => e
    puts e if $DEBUG
  end
end
