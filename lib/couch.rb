require 'couchrest_model'
require 'digest/md5'

module ErnieBrodeur
  module Couch
    DB = CouchRest.database! "http://localhost:5984/#{App.name}"
  end
end

# TODO not suck here by hardcoding this.
Dir.glob('/home/ebrodeur/Projects/bin_snippets/lib/models/*.rb').each do |f|
  require f
end
