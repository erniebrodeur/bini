module ErnieBrodeur
	class Application
		attr_accessor :version
		attr_accessor :banner
		attr_accessor :long_description

		# return the name of the app, for now this is just the cmd ran, later it will be
		# something generated but more unique.
		def name
			$0.split("/").last
		end

		def initialize
			@version = '0.0.0'
			@banner  = 'A bin snippet by Ernie Brodeur that does . . . something.'
			@long_description = ''
		end
	end

	App = Application.new
end
