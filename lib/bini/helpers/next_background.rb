require 'mixins'

module Bini
  module NextBackground
    def add_directory(dir)
      files = Dir.glob("#{dir}**/*")
      Log.info "Found #{files.count}, starting scanning . . . "
      files.each do |file|
        add_file file
      end
    end

    def add_file(filename)
      @file = Bini::DM::Models::Image.first_or_new(:filename => ::File.absolute_path(filename))
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
        # I get back everything here, I'm more interested in accurate results.
        # also, I rationalize the number to 'scrub' near-like floats into the same known ratios, ie: 16/9, 4/3.
        new_f = Bini::DM::Models::Image.all(:fields => [:filename, :ratio]).select{ |x| x.ratio.rationalize(0.01) == 0.5625.rationalize(0.01)}.rand.filename
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

    def stats
      e = Bini::DM::Models::Image.all

      sizes = e.map{|x| x.ratio}.uniq.sort

    end
  end
end
