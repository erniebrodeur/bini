require 'fileutils'

module Bini
  extend self

  # A helper for storing configuration related data in.
  Config = Sash.new file:"#{Bini.config_dir}/#{Bini.name}.yaml"
end
