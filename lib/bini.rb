require 'yajl'
require 'sys/proctable'

require "bini/sash"
require "bini/version"
require "bini/filemagic"

module Bini
  extend self

  attr_accessor :cache_dir
  attr_accessor :config_dir

  def long_name=(name)
    @long_name = name
  end

  def long_name
    @long_name ||= $0.split("/").last if !@name
  end
  def cache_dir=(dir)
    @cache_dir = dir
  end

  def cache_dir
    @cache_dir ||= "#{Dir.home}/.cache/bini/#{$0}/"
  end

  def config_dir=(dir)
    @config_dir = dir
  end

  def config_dir
    @config_dir ||= "#{Dir.home}/.cache/bini/#{$0}/"
  end

  def pids
    a = Sys::ProcTable.ps.select{|x| x.cmdline =~ /.*#{@name}.*-[dD].*/}.map {|x| x.pid}
    a.delete $$
    return a if a.any?
    nil
  end


  def daemonize(*params, &block)
    if params[0] && !params[0][:multiple_pids] && pids
      puts_or_log :info, "#{@name} appears to be running (#{pids}), only one allowed, exiting."
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

  # Adds a rails style configure method (@benwoody's unknown contribution)
  def configure
    yield self
    parameters
  end

  # List available parameters and values in those params
  def parameters
    @values = {}
    keys.each { |k| @values.merge! k => Bini.send(k) }
    @values
  end
  alias_method :params, :parameters

  # Returns true or false if all parameters are set.
  def parameters?
    parameters.values.all?
  end

  # A [Array] of keys available in Bini.
  def keys
    keys ||= [:cache_dir, :config_dir]
  end

  private

  # Helper to clean up recursive method in #parameters
  def get_var(var)
    self.instance_variable_get(var)
  end

  private
  def puts_or_log(l, s)
    if @plugins.include? 'logging'
      Log.send l, s
    else
      puts s
      exit if l.to_sym == :fatal
    end
  end
end
