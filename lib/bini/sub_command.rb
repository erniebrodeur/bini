require 'bini/optparser'
module Bini
  module SubCommand
    extend self

    attr_accessor :prefix

    @global_parser = Bini::OptionParser.new false
    @bail = false

    # return's a hash of name:path of plugins
    def plugins
      @plugins ||= list_plugins

      return @plugins
    end

    def fire!(options = {})
      plugins.each do |word,path|
        if ARGV.include? word
          # We found our command, time to split here.
          index = ARGV.index word
          Bini::SubCommand.global_parser.parse! ARGV[0...index]
          exit if @bail == true

          # This is/ a load, so the state is set.
          load path
        end
      end
    end

    def list_plugins
      plugins ||= generate_plugin_list
    end

    def list_plugin_execs
      output = []
      plugins.each do |g|
        output += Gem::Specification.find_by_name("#{prefix}-#{g}").executables
      end
      output
    end

    private

    def generate_plugin_list
      Gem::Specification.find_all {|s| s.name =~ /#{prefix}-/}.map {|i| i.name.split(/-/)[1]}.uniq
    end

  end
end
