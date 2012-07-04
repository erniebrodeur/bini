require 'couchrest_model'
require 'digest/md5'

module ErnieBrodeur
  module Couch
    DB = CouchRest.database! "http://localhost:5984/#{App.name}"
  end

  App.plugins.push 'couch'
end

# TODO not suck by hard coding this

# since we have to have a specific order, lets just make a word list real quick.
%w{file image}.each do |f|
	require "/home/ebrodeur/Projects/bin_snippets/lib/models/#{f}"
end
