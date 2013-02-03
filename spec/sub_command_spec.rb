require "spec_helper"
require "cli_spec_helper"

describe "Sub commands on the CLI" do
  it "will have a prefix"
  it "will have a path like statement"
  context "when you type prefix command" do
    it "will parse the ARGV first upto subcommand"
    it "will execute prefix-command"
    it "will exit if asked (think --help)"
    it "will fail gracefully if it can't find prefix-comand"
    it "will command parse the remainder of ARGV"
  end

  context "when you type just the command" do
    it "will be aware of installed commands"
    it "will provide basic help"
  end
end
