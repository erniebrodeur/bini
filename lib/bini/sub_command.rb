# Last: You built out the test gem, included it in gem via github.
# Next: Build gather executables and build out test
# Next++: remember, look for bin/prefix-command in our pluginlist, execute
require 'bini/optparser'
module Bini
  module SubCommand
    extend self

    attr_accessor :prefix

    @global_parser = Bini::OptionParser.new false
    @bail = false

    # return's a hash of name:path of plugins
    def plugins
      @plugins ||= generate_plugin_list
    end

    def executables
      @executables ||= generate_executable_list
    end

    def fire
      plugins.each do |word,path|
        if ARGV.include? word
          # We found our command, time to split here.
          index = ARGV.index word
          Bini::SubCommand.global_parser.parse! ARGV[0...index]
          exit if @bail == true

          # finally, load the executable to get the process started
          load path
        end
      end
    end

    private
    def generate_executable_list
      output = []
      Bini::SubCommand.plugins.each do |g|
        spec = Gem::Specification.find_by_name(g)
        output += spec.executables.map {|i| "#{spec.bin_dir}/#{i}"}
      end
      puts output
      output
    end

    def generate_plugin_list
      Gem::Specification.find_all {|s| s.name =~ /#{@prefix}-/}.map {|g| g.name }
    end

  end
end
