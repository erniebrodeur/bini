module ErnieBrodeur
  module NextBackground
    def add_directory(dir)
      Dir.glob("#{dir}**/*").each do |file|
        add_file file
      end
    end

    def add_file(file)
      # does it exist in the data base? if so return it
      if (f = ErnieBrodeur::Models::Image.find(file))
        puts "File existed: #{file}"
        return f
      end
      # Is our file an image?  if not, just return nil.
      return nil if !ErnieBrodeur::is_image?(file)
      puts "Adding file: #{file}"
      begin
        ErnieBrodeur::Models::Image.create!(:filename => file, :md5sum => true)
      rescue
      end
    end

    def run_once
      return nil if !Config["output_files"]

      @list = ErnieBrodeur::Models::Image.by_ratio.select {|i| i.ratio == 1.778} if !@list
      Config["output_files"].each do |f|
        File.delete f if File.symlink? f
        puts "Deleted #{f}"

        new_f = @list[Random.rand(@list.count)].filename
        File.symlink new_f, f
        puts "Linked #{new_f} to #{f}"
        %x[xfdesktop --reload]
        puts "Reloaded xfce4."
      end
    end

    def daemonize
      App.daemonize(:mulitple_pids => false) {
        loop do
          run_once
          sleep 10
        end
      }
    end
  end
end
