# an includable version of sash.  May end up the 'base' version.

module Bini
  module Extensions
    module Savable
      include HashMetadata

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
        metadata[:savable][:dirty] = false

        return true
      end

      # load the into self
      def load
      end

      # set the config mode
      def set_mode(mode = nil)
        if metadata[:savable]
      end

      # has something updated that means we need to save
      def is_dirty?
        return true if metadata[:savable][:dirty] == true
        return false
      end

      # clean the system of residual files (obviously destructive).
      def clean_files
        #FileUtils.rm metadata[:savable][:file], v
      end

    end
  end
end
