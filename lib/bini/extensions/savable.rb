module Bini
  module Extensions
    module Savable

      # Lets setup some options.
      def initialize
        options[:dirty] = false
        options[:file] = "#{Bini.config_dir}/#{Bini.long_name}/savable.yaml"
        super
      end

      def []=(key,value)
        super key, value
        if options[:autosave] == true
          save
        else
          options[:dirty] = true
        end
        return value
      end

      # save self into a file
      def save
        return false if options[:dirty] && options[:dirty] != true

        FileUtils.mkdir_p basedir if !Dir.exist? basedir

        # I do this the long way because I want an immediate sync.
        f = open(options[:file], 'w')

        # make a plan hash, save that instead of the class.
        f.write(YAML::dump({}.merge(self)))
        f.sync
        f.close

        backup if options[:backup]
        set_mode if options[:mode]
        options[:dirty] = false
        return true
      end

      def load
        self.clear
        if options[:file] && File.exist?(options[:file]) && File.stat(options[:file]).size > 0
          h = YAML::load open(options[:file], 'r').read
          h.each { |k,v| self[k] = v}
        end
        return self
      end

      # Generate a backup file real quick.
      def backup
        FileUtils.cp options[:file], backup_file if File.file? options[:file]
      end

      # Set the mode of both the save file and backup file.
      def set_mode
        FileUtils.chmod options[:mode], options[:file] if options[:mode] && File.exist?(options[:file])

        return true if !backup_file
        FileUtils.chmod options[:mode], backup_file if File.exist? backup_file
        return true
      end


      # has something updated that means we need to save
      def is_dirty?
        return true if options[:dirty] == true
        return false
      end

      # clean the system of residual files (obviously destructive).
      def clean_files
        #FileUtils.rm options[:file], v
        return true if !options[:file]
        FileUtils.rm options[:file] if File.file? options[:file]
        FileUtils.rm backup_file if File.file? backup_file
        return true
      end

      def options
        @options ||= Hash.new
      end

      # The base directory of the save file.
      def basedir
        File.dirname File.absolute_path options[:file]
      end

      # The save file plus an extension.
      def backup_file
        "#{options[:file]}.bak"
      end
    end
  end
end
