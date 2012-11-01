require 'fileutils'

module Bini
  attr_accessor :config

  extend self

  self.config = Sash.new file:"#{Bini.config_dir}/#{Bini.name}.yaml"
end
