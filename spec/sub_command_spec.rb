require "spec_helper"
require "cli_spec_helper"
require 'bini-test-subcommand'


describe "Sub commands on the CLI" do
  before (:each) do
    Bini::SubCommand.prefix = 'bini-test'
    @commands = ["4subcommand", "subcommand","subcommand-two","subcommand_three"]
    @test_plugins = "test-subcommand"
  end

  it "will have a prefix"
  it "will scan your gemspecs for possible plugins."
  context "when you type prefix command" do
    it "will parse the ARGV first upto subcommand"
    it "will execute prefix-command with the remainder of ARGV"
    it "will exit if asked (think --help) at the prefix level"
    it "will fail gracefully if it can't find prefix-command (with --help)"
    it "will pass the rest of ARGV to prefix-command"
  end

  context "when you type just the command" do
    it "will be aware of installed commands"
    it "will provide basic help"
  end

  describe "unit like tests" do
    describe Bini::SubCommand do
      describe "#list_plugins" do
      end

      describe "#plugins" do
        it 'will generate an array of possible plugins' do
          Bini::SubCommand.plugins.kind_of?(Array).should be_true
          Bini::SubCommand.plugins.any?.should be_true
        end
      end
      describe "#executable" do
        it "will generate an array of available executables" do
          Bini::SubCommand.executables.kind_of?(Array).should be_true
          Bini::SubCommand.executables.any?.should be_true
        end
        it "will default to all, or you can pass a specific plugin"
      end
    end
  end
end
