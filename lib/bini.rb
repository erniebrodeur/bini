require 'yajl'
require 'sys/proctable'

require "bini/sash"
require "bini/version"
require "bini/filemagic"

module Bini
  extend self

  attr_accessor :defaults

  # I break this out so that I can use long name right away, this allows methods
  # like configure to work.

  @defaults = {}
  @defaults[:long_name] = $0.split("/").last
  @defaults[:cache_dir] = "#{Dir.home}/.cache/bini/#{@long_name}/"
  @defaults[:config_dir] = "#{Dir.home}/.config/bini/#{@long_name}/"

  # Dynamic attribute's based off the keys.
  def keys
    [:long_name, :cache_dir, :config_dir]
  end

  keys.each do |key|
    define_method(key) do
      v = instance_variable_get "@#{key}"
      return @defaults[key] if !v
      return v
    end
    define_method("#{key}=".to_sym) do |dir|
      instance_variable_set "@#{key}", dir
    end
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

