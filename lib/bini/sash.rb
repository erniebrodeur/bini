require 'fileutils'
require 'yaml'

module Bini
  # This is a savable hash, it can be configured and used to store whatever the# contents of the hash are for loading later.  Will serialize in yaml to keep all
  # the dependencies in ruby stdlib.
  class Sash < Hash
    include Bini::Extensions::Savable

    # overrides:{Hash.new}
    # options: Sash options.
    def initialize(params = {})
      # if we get any params not listed above, throw an exception.
      p = params.select { |k,v| k != :options && k != :overrides}
      raise ArgumentError, "Extra values passed in: #{p}" if p.count > 0

      # set our options to our attributes.
      options.merge! params[:options] if params[:options]

      load if self.options[:autoload]

      self.merge! params[:overrides] if params[:overrides]

      return self
    end
  end
end

