# This library is to reduce the amount of effort I need to build a binary with option parsing
# and sensable defaults.  It is not intended to be convient for anybody but me, their
# are a host of good options out there if you want cli tools.

require 'optparse'
require 'ostruct'

### Options Block
Options = OpenStruct.new
Options.verbose = false
Options.version = false

OptionParser.new do |opts|
  opts.banner = Banner

  opts.on("-v", "--[no-]verbose", "Run verbosely") { |verbose| Options.verbose = v }
  opts.on("-V", "--version", "Print version") { |version| Options.version = true}
end.parse!

if Options.version
	puts Version
	exit 0
end
