require 'fileutils'
require 'yaml'

module Bini
  # This is a savable hash, it can be configured and used to store whatever the# contents of the hash are for loading later.  Will serialize in yaml to keep all
  # the dependencies in ruby stdlib.
  class Sash < Hash

    attr_accessor :file
    attr_accessor :backup
    attr_accessor :mode
    attr_accessor :auto_load
    attr_accessor :auto_save



    # initialization sets the values of the class Sash, not the contents of the Hash.
    def initialize(params = {})
      params.each { |k,v| instance_variable_set "@" + k.to_s,v}
      load if @auto_load
    end

    # The base directory of the save file.
    def basedir
      return nil if !file
      File.dirname File.absolute_path @file
    end

    # The save file plus an extension.
    def backup_file
      "#{@file}.bak"
    end

    # Save the hash to the file, check for backup and set_mode.
    def save
      if any?
        FileUtils.mkdir_p basedir if !Dir.exist? basedir
        backup if @backup

        # I do this the long way because I want an immediate sync.
        f = open(@file, 'w')
        f.write YAML::dump self
        f.sync
        f.close

        set_mode if @mode
      end
      true
    end

    def []=(key,value)
      store key, value
      save! if @auto_save == true
    end
    # Save the hash to a file, overwriting if necessary.
    def save!
      delete_file
      save
    end

    # Load the save file into self.
    def load
      self.clear
      if @file && File.exist?(@file) && File.stat(@file).size > 0
        h = YAML::load open(@file, 'r').read
        h.each { |k,v| self[k.to_sym] = v}
        return true
      end
      false
    end

    # Generate a backup file real quick.
    def backup
      FileUtils.cp @file, backup_file if File.file? @file
    end

    # Set the mode of both the save file and backup file.
    def set_mode
      # Why are we trying to set_mode when we don't even have a file?
      return false if !@file
      File.chmod @mode, @file if File.exist? @file

      # the backup file may not exist for whatever reason, lets not shit if it doesn't.
      return true if !backup_file
      File.chmod @mode, backup_file if File.exist? backup_file
      true
    end

    private

    # Delete the save file.
    def delete_file
      return false if !@file
      FileUtils.rm @file if File.file? @file
      return true
    end
  end
end
