module ErnieBrodeur
  module NextBackground
    def add_directory(dir)
      files = Dir.glob("#{dir}**/*")
      Log.info "Found #{files.count}, starting scanning . . . "
      files.each do |file|
        add_file file
      end
    end

    def add_file(filename)
      @file = ErnieBrodeur::DM::Models::Image.first_or_new(:filename => filename)
      @file.gen_md5
      @file.save
    end

    def run_once
      if !Config[:output_files]
        Log.info 'Nothing configured! exiting.'
        exit
      end

      Config[:output_files].each do |f|
        File.delete f if File.symlink? f
        Log.info "Deleted #{f}"
        new_f = ErnieBrodeur::DM::Models::Image.all(:fields => [:filename, :ratio], :ratio => 1.778).rand.filename
        File.symlink new_f, f
        Log.info "Linked #{new_f} to #{f}"
        %x[xfdesktop --reload]
        Log.info "Reloaded xfce4."
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
    def kill_daemon
      App.kill_daemon
    end
  end
end
