require 'bini/optparser'
module Bini
  module SubCommand
    extend self

    attr_accessor :global_parser
    @global_parser = Bini::OptionParser.new false

    attr_accessor :prefix
    @prefix = 'git'

    attr_accessor :bin_path
    @bin_path = "./bin:#{ENV["PATH"]}"

    attr_accessor :bail
    @bail = false

    # return's a hash of name:path of commands
    def commands
      @commands ||= find_commands

      return @commands
    end

    def exec(cmd, opts = {})
      @commands.each do |word,path|
        word = word.to_s
        if ARGV.include? word
          # We found our command, time to split here.
          index = ARGV.index word
          Bini::SubCommand.global_parser.parse!  ARGV[0...index]
          exit if @bail = true
          puts "#{path} #{ARGV[index+1..-1].join " "}"
        end
      end

    end

    def find_commands
      @commands ||= {}
      @bin_path.split(":").each do |path|
        files = Dir.glob("#{path}/#{prefix}-*")
        files.each {|f| @commands[file_to_command(f).to_sym] = f}
      end

      return @commands
    end

    private
    def file_to_command(filename)
      return filename.split("/").last.split("-").last
    end
  end
end



