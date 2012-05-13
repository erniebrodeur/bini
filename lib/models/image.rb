require 'mini_magick'

module ErnieBrodeur
  module Models
    # You must always supply the filename.
    class Image < ErnieBrodeur::Models::File
      use_database ErnieBrodeur::Couch::DB

      property :width,    Fixnum
      property :height,   Fixnum
      property :format,   String
      property :ratio,    Float

      def initialize(*params)
        super
        params = params[0]

        gen_image if self.filename
      end

      def gen_image
        i = MiniMagick::Image.open filename
        self.width = i[:width]
        self.height = i[:height]
        self.format = i[:format]
        self.ratio = width / height
      end
    end
  end
end
