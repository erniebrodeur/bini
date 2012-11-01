require 'fileutils'

module Bini
  attr_accessor :config

  extend self

  self.config = Sash.new file:"#{App.config_dir}/#{App.name}.yaml"
end
