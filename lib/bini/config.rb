require 'fileutils'

module Bini
  extend self

  # A helper for storing configuration related data in.
  Config = Sash.new options:{file:"#{Bini.config_dir}/#{Bini.name}.yaml"}
end
