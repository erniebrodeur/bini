require 'couchrest_model'
require 'digest/md5'

module Bini
  module Couch
    DB = CouchRest.database! "http://localhost:5984/#{App.name}"
  end

  App.plugins.push 'couch'
end

# since we have to have a specific order, lets just make a word list real quick.
%w{file image}.each do |f|
  require "bini/models/couch/#{f}"
end
