module ErnieBrodeur
  module DM
    module Models
      class Image < ErnieBrodeur::DM::Models::File
        self.raise_on_save_failure = true

        property :width,        Float
        property :height,       Float
        property :format,       String
        property :transparency, Boolean
        property :ratio,        Float

        def initialize(*params)
          super

          gen_image if self.filename && !self.ratio
        end

        def gen_image
          i = ErnieBrodeur::DM::Models::image_info filename

          if i
            self.width = i[:width]
            self.height = i[:height]
            self.format = i[:type]
            self.transparency = i[:transparency] == "True" ? true : false
            self.ratio = (width / height)
          end
        end

      end

      def self.random_image
        ErnieBrodeur::DM::Models::File.all[Random.rand(ErnieBrodeur::DM::Models::File.all.count)]
      end

      # Use image magick to determine the basic properties of the image.
      def self.image_info(filename)
        return nil if !::File.exist? filename
        return nil if !ErnieBrodeur::DM::Models.is_image? filename

        #TODO not have this unrolled, make it more dynamic.
        width, height, type, transparency =  %x[identify -ping -format '%w %h %m %A' '#{filename}'].split

        h = {}
        h[:width] = width.to_f
        h[:height] = height.to_f
        h[:type] = type
        h[:transparency] = transparency
        h
      end

      # Check the filemagic to see if it's an image or not.
      def self.is_image?(filename)
        FileMagic.mime_type(filename).start_with? 'image'
      end
    end
  end
end
