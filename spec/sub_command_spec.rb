require "spec_helper"
require "cli_spec_helper"

describe "Sub commands on the CLI" do
  it "will have a prefix"
  it "will have a path like statement"
  context "when you type prefix command" do
    it "will parse the ARGV first upto subcommand"
    it "will execute prefix-command with the remainder of ARGV"
    it "will exit if asked (think --help) at the prefix level"
    it "will fail gracefully if it can't find prefix-comand (with --help)"
    it "will pass the rest of ARGV to prefix-command"
  end

  context "when you type just the command" do
    it "will be aware of installed commands"
    it "will provide basic help"
  end
end
