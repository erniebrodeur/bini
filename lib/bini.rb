require 'sys/proctable'

require "bini/sash"
require "bini/version"
require "bini/filemagic"

# A collection of very small helpers that assist me in writing a CLI without
# getting in the way.
#
# Provides some dynamic attributes, they all behave the same and just hook into
# the defaults to provide non-nil results when needed.
#
# @!attribute long_name [rw]
#  @return [String] An application name, useful if your app is named differently then your binary.
# @!attribute cache_dir [rw]
#  @return [String] The directory to store any cache related files.
# @!attribute config_dir [rw]
#  @return [String] The directory to store any config related files.
# @!attribute version [rw]
#  @return [String] The version of the application, not of Bini.
module Bini
  extend self

  # A collection of sane defaults to be provided if the same attr is still nil.
  attr_accessor :defaults

  # I break this out so that I can use long name right away, this allows methods
  # like configure to work.

  @defaults = {}
  @defaults[:long_name] = $0.split("/").last
  @defaults[:cache_dir] = "#{Dir.home}/.cache/bini/#{@long_name}/"
  @defaults[:config_dir] = "#{Dir.home}/.config/bini/#{@long_name}/"

  # Dynamic attribute's based off the keys.
  def keys
    keys ||= [:long_name, :cache_dir, :config_dir, :version]
  end

  keys.each do |key|
    define_method(key) do
      v = instance_variable_get "@#{key}"
      return !v ? @defaults[key] : v
    end
    define_method("#{key}=".to_sym) do |dir|
      instance_variable_set "@#{key}", dir
    end
  end

  # Adds a rails style configure method.
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

  # Returns true or false if all parameters are set to something other than defaults.
  def parameters?
    @defaults.map {|k,v| @defaults[k] != parameters[k]}.all?
  end

  # I feel like I should split this into it's own file, but for now.
  # Autoloads.

  autoload :OptionParser, 'bini/optparser'
end
