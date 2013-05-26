require 'fileutils'
require 'yaml'

module Bini
  # a class version of Sash.
  class Sash < Hash
    include Bini::Extensions::Savable
  end
end

