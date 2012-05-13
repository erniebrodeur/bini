module ErnieBrodeur
  class ConfigBlob
    BaseDir = "/home/ebrodeur/.config/erniebrodeur"
    attr_accessor :configuration

    FileUtils.mkdir_p BaseDir if !Dir.exist? BaseDir
    def initialize
      load
    end

    def file
      "#{BaseDir}/#{App.name}.json"
    end

    def save
    	if @configuration.any?
    		# I do this the long way because I want an immediate sync.
    		f = open(file, 'w')
    		f.write Yajl.dump @configuration
    		f.sync
    		f.close
   		end
    end

    def load
    	if File.exist? self.file
      	@configuration = Yajl.load open(file, 'r').read
      else
      	@configuration = {}
      end
    end
  end

  Config = ConfigBlob.new
end
