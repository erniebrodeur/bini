# an includable version of sash.  May end up the 'base' version.
require 'yaml'

module Bini
  module Extensions
    module Savable
      include Bini::Extensions::Metadata

      # Lets setup some metadata.
      def initialize
        metadata[:savable] = {
          file:"#{Bini.config_dir}/savable.yaml",
          dirty:false
        }
        super
      end

      def []=(key,value)
        super key, value
        metadata[:savable][:dirty] = true
      end

      # save self into a file
      def save
        return false if metadata[:savable][:dirty] && metadata[:savable][:dirty] != true

        FileUtils.mkdir_p basedir if !Dir.exist? basedir
        backup if metadata[:savable][:backup]

        # I do this the long way because I want an immediate sync.
        f = open(metadata[:savable][:file], 'w')

        # make a plan hash, save that instead of the class.
        f.write(YAML::dump({}.merge(self)))
        f.sync
        f.close

        set_mode if metadata[:savable][:dirty]
        metadata[:savable][:dirty] = false
        return true
      end

      def load
        self.clear
        if metadata[:savable][:file] && File.exist?(metadata[:savable][:file]) && File.stat(metadata[:savable][:file]).size > 0
          h = YAML::load open(metadata[:savable][:file], 'r').read
          h.each { |k,v| self[k] = v}
        end
        return self
      end

      # Generate a backup file real quick.
      def backup
        FileUtils.cp metadata[:savable][:file], backup_file if File.file? metadata[:savable][:file]
      end

      # Set the mode of both the save file and backup file.
      def set_mode
        # Why are we trying to set_mode when we don't even have a file?
        return false if !metadata[:savable][:file]
        File.chmod metadata[:savable][:mode], metadata[:savable][:file] if File.exist? metadata[:savable][:file]

        # the backup file may not exist for whatever reason, lets not shit if it doesn't.
        return true if !backup_file
        File.chmod metadata[:savable][:mode], backup_file if File.exist? backup_file
        true
      end


      # has something updated that means we need to save
      def is_dirty?
        return true if metadata[:savable][:dirty] == true
        return false
      end

      # clean the system of residual files (obviously destructive).
      def clean_files
        #FileUtils.rm metadata[:savable][:file], v
        return false if !metadata[:savable][:file]
        FileUtils.rm metadata[:savable][:file] if File.file? metadata[:savable][:file]
        return true
      end

      private
      # The base directory of the save file.
      def basedir
        return nil if !metadata[:savable][:file]
        File.dirname File.absolute_path metadata[:savable][:file]
      end

      # The save file plus an extension.
      def backup_file
        "#{metadata[:savable][:file]}.bak"
      end
    end
  end
end
