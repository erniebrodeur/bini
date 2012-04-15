module ErnieBrodeur
	class Application
		attr_accessor :version
		attr_accessor :banner
		attr_accessor :long_description

		def initialize
			@version = '0.0.0'
			@banner  = 'A bin snippet by Ernie Brodeur that does . . . something.'
			@long_description = ''
		end
	end

	App = Application.new
end
