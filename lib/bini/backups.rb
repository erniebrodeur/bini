module Bini
  class Backups
    attr_accessor :index

    def initialize(params = {})
      index_file = params[:index_file] if params[:index_file]
      index_file ||= Bini.backup_dir + "/index.json"

      @index = Sash.new options:{autoload:true, file:index_file, backup:true}
    end

    def generate_key(filename)
      Digest::SHA256.hexdigest open(filename).read
    end


    def store(filename)
      hex = generate_key(filename)
      hex_file = "#{Bini.backup_dir}"
      index[hex] = Array.new if !index[hex]
      index[hex] << filename

      FileUtils.mkdir_p Bini.backup_dir
      FileUtils.cp "#{filename}", "#{Bini.backup_dir}/#{hex}"
      index.save
    end

    def restore(filename)
      hex = generate_key filename

      return false if !index[hex] || !index[hex].include?(filename)

      FileUtils.cp "#{Bini.backup_dir}/#{hex}", filename
      index[hex].delete! filename
      index.delete_if {|k,v| k == hex} if index[hex].empty?
      index.save
    end
  end
end
