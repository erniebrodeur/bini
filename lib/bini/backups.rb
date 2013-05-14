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

    # this is slightly better then restore, but still not very clear.
    def store(filename)
      hex = generate_key(filename)
      hex_file = "#{Bini.backup_dir}"

      index[hex] = Array.new if !index[hex]
      index[hex] << [filename, File.stat(filename).mode] if !index[hex].flatten.include? filename

      FileUtils.mkdir_p Bini.backup_dir
      FileUtils.cp "#{filename}", "#{Bini.backup_dir}/#{hex}"

      index.save
    end

    # this is just not elegant.
    def restore(filename)
      raise "ohShit, it appears the index has two sha256sums for one filename." if duplicate_hex? filename

      hex = get_hex filename
      return false if !check_hex(filename, hex)

      restore_file = "#{Bini.backup_dir}/#{hex}"
      FileUtils.cp restore_file, filename

      mode = index[hex].select {|i| i[0] == filename}.first.last
      FileUtils.chmod mode, restore_file

      index[hex].delete_if {|i| i[0] == filename}
      index.delete_if {|k,v| k == hex} if index[hex].empty?
      index.save
    end

    def duplicate_hex?(filename)
      results = index.select {|k,v| v.flatten.include? filename }
      return true if results.size > 1
      return false
    end

    def get_hex(filename)
      index.select {|k,v| v.flatten.include? filename }.keys.first
    end

    def stored?(filename)
      index.include? generate_key filename
    end

    def check_hex(filename, hex)
      return false if !index[hex] || !index[hex].flatten.include?(filename)
      restore_hex = generate_key(filename)
      return false if restore_hex && restore_hex != hex
      return true
    end
  end
end

