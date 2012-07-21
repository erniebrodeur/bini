require 'fileutils'

module ErnieBrodeur
  class ConfigBlob < Hash
    BaseDir = "/home/ebrodeur/.config/erniebrodeur"

    def initialize(load = true)
      FileUtils.mkdir_p BaseDir if !Dir.exist? BaseDir
      load if load
    end

    def file
      "#{BaseDir}/#{App.name}.json"
    end

    def save
      if any?
        # I do this the long way because I want an immediate sync.
        f = open(file, 'w')
        f.write Yajl.dump self
        f.sync
        f.close
      end
    end

    def save!
      FileUtils.rm file if File.file? file
      save
    end

    def load
      if File.exist? self.file
        h = Yajl.load open(file, 'r').read
        h.each { |k,v| self[k.to_sym] = v}
      end
    end
  end
  App.plugins.push 'config'
  Config = ConfigBlob.new
end
