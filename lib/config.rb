module ErnieBrodeur
  class ConfigBlob
    BaseDir = "/home/ebrodeur/.config/erniebrodeur"

    attr_accessor :configuration

    def initialize
    	FileUtils.mkdir_p BaseDir if !Dir.exist? BaseDir
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

    def [](k)
    	@configuration[k]
    end

    def []=(k,v)
    	@configuration[k] = v
    end

    def to_s
    	@configuration.to_s
    end
  end
  App.plugins.push 'config'
  Config = ConfigBlob.new
end
