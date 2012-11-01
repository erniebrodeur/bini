module Bini
  module FileMagic
    extend self

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
