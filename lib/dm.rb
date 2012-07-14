require 'data_mapper'
require 'dm-types'

module ErnieBrodeur
  module DM
  	def self.db_path
  		# TODO not hardcode this.
  		"/home/ebrodeur/.config/erniebrodeur/#{App.name}.db"
  	end

  	def self.initialize
  		DataMapper::Logger.new($stdout, :debug)
   		DataMapper.setup(:default, "sqlite://#{db_path}")

			%w{file}.each do |f|
			  require "models/dm/#{f}"
			end

			DataMapper.auto_upgrade!
   	end

   	self.initialize
  end
  App.plugins.push 'dm'
end
