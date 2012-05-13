module ErnieBrodeur
  module Models
    # You must always supply the filename.
    class File < CouchRest::Model::Base
      use_database ErnieBrodeur::Couch::DB

      property :_id, String, :alias => :filename
      property :mtime,   Time
      property :ctime,   Time
      property :atime,   Time
      property :ftype,   String
      property :size,   Integer
      property :md5sum, String

      view_by :filename
      view_by :md5sum

      # This allows us to optionally do some basic processing of the file.
      def initialize(*params)
        super
        params = params[0]

        if params[:filename]
          self.filename = ::File.absolute_path params[:filename]
          stats = ::File.stat self.filename
          %w{mtime ftype size}.each do |w|
            eval "self.#{w} = stats.#{w}"
          end
        end

        #options!
        gen_md5 if params[:md5sum]
      end

      def gen_md5
        self.md5sum = Digest::MD5.hexdigest self.filename
      end
    end
  end
end
