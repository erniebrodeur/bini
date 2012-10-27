require 'fileutils'

module Bini
  class ConfigBlob < Hash
    def initialize(load = true)
      self.load if load
    end

    def file
      "#{App.config_dir}/#{App.name}.json"
    end

    def save
      if any?
        FileUtils.mkdir_p App.config_dir if !Dir.exist? App.config_dir
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
      if File.exist?(self.file) && File.stat(self.file).size > 0
        h = Yajl.load open(file, 'r').read
        h.each { |k,v| self[k.to_sym] = v}
      end
    end
  end
  App.plugins.push 'config'
  Config = ConfigBlob.new
end
