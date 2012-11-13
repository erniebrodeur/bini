require 'fileutils'

module Bini
  # @attr_reader [Sash] config A helper for storing configuration related data in.
  attr_accessor :config

  extend self

  self.config = Sash.new file:"#{Bini.config_dir}/#{Bini.name}.yaml"
end
