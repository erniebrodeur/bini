module Bini
  class Backups
    attr_accessor :index

    def initialize(params = {})
      index_file = params[:index_file] if params[:index_file]
      index_file ||= Bini.backup_dir + "/index.json"

      @index = Sash.new options:{auto_load:true, file:index_file, backup:true}
    end

    def generate_key(filename)
      return nil if !File.exists? filename
      return Digest::SHA256.hexdigest(open(filename).read)
    end


    def store(filename)
      hex = generate_key(filename)
      hex_file = "#{Bini.backup_dir}"
      index[hex] = Array.new if !index[hex]
      index[hex] << filename if !index[hex].include? filename

      FileUtils.mkdir_p Bini.backup_dir
      FileUtils.cp "#{filename}", "#{Bini.backup_dir}/#{hex}"
      index.save
    end

    def restore(filename)
      raise "ohShit" if duplicate_hex? filename

      hex = index.select {|k,v| v.include? filename }.keys.first
      return false if !index[hex] || !index[hex].include?(filename)
      restore_file = "#{Bini.backup_dir}/#{hex}"

      current_hex = generate_key(filename)
      return false if current_hex && current_hex != hex

      FileUtils.cp restore_file, filename, verbose:true
      index[hex].delete filename
      index.delete_if {|k,v| k == hex} if index[hex].empty?
      index.save
    end

    def files(hex)
      index[hex]
    end

    def duplicate_hex?(filename)
      results = index.select {|k,v| v.include? filename }
      return true if results.size > 1
      return false
    end

    def stored?(filename)
      index.include? generate_key filename
    end
  end
end
