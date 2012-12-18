module Bini
  # A collection of helpers related to file management.
  module FileMagic
    extend self

    # Call the system app 'file' to check mimetype.
    # @param [String] file name of the file.
    # @return [String] of the mimetypes found
    # @return [Nil] if nothing worked.
    def mime_type(file)
      return `file -bk --mime-type "#{file}"`.chomp! if File.exist? file
      return nil
    end

    private
    def filemagic_version
      `file -v`.split(/^file-(.*)\nmagic file from (.*)\n/)[1]
    end
  end
end
