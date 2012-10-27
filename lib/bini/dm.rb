require 'data_mapper'

module Bini
  module DM
  	def self.db_path
  		"#{App.config_dir}/#{App.name}.db"
  	end

  	def self.initialize
  		DataMapper::Logger.new($stdout, :debug)
   		DataMapper.setup(:default, "sqlite://#{db_path}")

			%w{file image}.each do |f|
			  require "bini/models/dm/#{f}"
			end

			DataMapper.auto_upgrade!
   	end

   	self.initialize
  end
  App.plugins.push 'dm'
end

module DataMapper
	class Collection
		def rand
			all[Random.rand(all.count)]
		end
	end
end
