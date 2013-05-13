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

  @defaults = {}
  @defaults[:long_name] = Proc.new { $0.split("/").last }
  @defaults[:cache_dir] = Proc.new { "#{Dir.home}/.cache/#{long_name}" }
  @defaults[:config_dir] = Proc.new { "#{Dir.home}/.config/#{long_name}" }
  @defaults[:data_dir] = Proc.new { "#{Dir.home}/.local/share/#{long_name}/data" }
  @defaults[:backup_dir] = Proc.new { "#{Dir.home}/.local/share/#{long_name}/backup" }
  @defaults[:version] = Proc.new { "v0.0.0" }

  # Dynamic attribute's based off the keys.
  def keys
    keys ||= [:long_name, :cache_dir, :config_dir, :backup_dir, :data_dir, :version]
  end

  keys.each do |key|
    define_method(key) do
      v = instance_variable_get "@#{key}"
      return v if v

      @defaults[key] ? default = @defaults[key].call : default = nil
      return default
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
end

