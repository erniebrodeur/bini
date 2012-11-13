require 'fileutils'

module Bini
  attr_accessor :config

  extend self

  # A helper for storing configuration related data in.
  Config = Sash.new file:"#{Bini.config_dir}/#{Bini.name}.yaml"
end
