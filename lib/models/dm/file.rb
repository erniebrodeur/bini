require 'digest/md5'

module ErnieBrodeur
  module DM
    module Models
      class File
        include DataMapper::Resource
        self.raise_on_save_failure = true

        property :id, 	Serial
        property :filename, Text, :key => true, :required => true
        property :mtime,   Time
        property :ctime,   Time
        property :atime,   Time
        property :ftype,   String
        property :size,   Integer
        property :md5sum, String

        # This allows us to optionally do some basic processing of the file.
        def initialize(*params)
          super

          stats = ::File.stat self.filename
          %w{mtime ftype size}.each do |w|
            eval "self.#{w} = stats.#{w}"
          end
        end

        def gen_md5
          if !self.md5sum
            puts "Generating md5sum for #{filename}"
            self.md5sum = Digest::MD5.hexdigest self.filename
          end
        end
      end
    end
  end
end
