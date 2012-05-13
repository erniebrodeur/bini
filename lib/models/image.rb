module ErnieBrodeur
  module Models
    # You must always supply the filename.
    class Image < ErnieBrodeur::Models::File
      use_database ErnieBrodeur::Couch::DB

      property :width,        Float
      property :height,       Float
      property :format,       String
      property :transparency, TrueClass
      property :ratio,        Float

      design do
        view :by_md5sum
        view :by_filename
        view :by_height
        view :by_width
        view :by_format
        view :by_ratio
      end

      def initialize(*params)
        super
        params = params[0]

        gen_image if self.filename && !self.ratio
      end

      def gen_image
        i = ErnieBrodeur::image_info filename

        if i
          self.width = i[:width]
          self.height = i[:height]
          self.format = i[:type]
          self.transparency = i[:transparency]
          self.ratio = width / height
        end
      end

    end
  end

  def self.random_image
    r = Random.rand(ErnieBrodeur::Models::Image.count)
    ErnieBrodeur::Models::Image.all.skip(r).limit(1).all
  end

  # Use image magick to determine the basic properties of the image.
  def self.image_info(filename)
    return nil if !File.exist? filename
    return nil if !ErnieBrodeur.is_image? filename

    #TODO not have this unrolled, make it more dynamic.
    width, height, type, transparency =  %x[identify -ping -format '%w %h %m %z %A' '#{filename}'].split

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
