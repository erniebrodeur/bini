$:.push '/home/ebrodeur/Projects/bin_snippets/lib'

# Some requires, they don't fit elsewhere.
require 'yajl'
require 'sys/proctable'
module ErnieBrodeur

  class Application
    attr_accessor :version
    attr_accessor :banner
    attr_accessor :long_description

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
      return true if Sys::ProcTable.ps.select{|x| x.cmdline.include? App.name}.count >= 2
      nil
    end

    def initialize
      @version = '0.0.0'
      @banner  = 'A bin snippet by Ernie Brodeur that does . . . something.'
      @long_description = ''
    end

    def daemonize(*params, &block)
      if params[0] && !params[0][:multiple_pids] && running?
        puts "#{App.name} appears to be running, only one allowed, exiting."
        exit
      end
      puts "Forking to background."

      Process.daemon
      block.call
    end
  end

  App = Application.new

  # This will load a helper, if it exists.
  f = "#{$:.last}/helpers/#{App.name}.rb"
  require f if File.exist? f
end
