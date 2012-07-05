$:.push '/home/ebrodeur/Projects/bin_snippets/lib'

# Some requires, they don't fit elsewhere.
require 'yajl'
require 'sys/proctable'
module ErnieBrodeur

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
      "#{Dir.home}/.cache/erniebrodeur/#{App.name}/"
    end

    def config_dir
      "#{Dir.home}/.config/erniebrodeur/#{App.name}/"
    end

    def running?
      return true if Sys::ProcTable.ps.select{|x| x.cmdline =~ /.*#{App.name}.*-[dD].*/}.count >= 2
      nil
    end

    def pids?
      a = Sys::ProcTable.ps.select{|x| x.cmdline =~ /.*#{App.name}.*-[dD].*/}.map {|x| x.pid}
      a.delete $$
      a
    end

    def initialize
      @version = '0.0.0'
      @banner  = 'A bin snippet by Ernie Brodeur that does . . . something.'
      @long_description = ''
      @plugins = []
    end

    def daemonize(*params, &block)
      if params[0] && !params[0][:multiple_pids] && running?
        puts "#{App.name} appears to be running (#{pids?}), only one allowed, exiting."
        exit
      end
      puts "Forking to background."

      Process.daemon
      block.call
    end

    def kill_daemon
      if !running?
        puts "No pids found, exiting."
        exit
      end

      pids?.each do |p|
        puts "Killing #{p}"
        %x[kill -9 #{p}]
      end
    end
  end

  App = Application.new

  # This will load a helper, if it exists.
  f = "#{$:.last}/helpers/#{App.name}.rb"
  require f if File.exist? f
end
