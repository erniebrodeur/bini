require 'yajl'
require 'sys/proctable'

require "bini/sash"
require "bini/version"
require "bini/filemagic"

module Bini
  attr_accessor :name
  attr_accessor :cache_dir
  attr_accessor :config_dir
  attr_accessor :banner

  # return the name of the app, for now this is just the cmd ran, later it will be
  # something generated but more unique.
  def initialize
    # basically don't call these if they are already provided.
    @name       = $0.split("/").last if !@name
    @cache_dir  = "#{Dir.home}/.cache/bini/#{@name}/" if !@cache_dir
    @config_dir = "#{Dir.home}/.config/bini/#{@name}/" if !@config_dir
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
    keys.each { |k| @values.merge! k => get_var("@#{k}") }
    @values
  end
  alias_method :params, :parameters

  # Returns true or false if all parameters are set.
  def parameters?
    parameters.values.all?
  end

  # A [Array] of keys available in Pushover.
  def keys
    keys ||= [:token, :user, :message, :title, :priority, :device]
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
