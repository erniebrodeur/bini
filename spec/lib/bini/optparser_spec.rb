require 'spec_helper'

describe "optparser" do
	before (:each) do
		Options.clear
		@key = random_hex 4
		@value = random_hex 4
	end

	it "behaves like a OptionParser." do
		Options.kind_of? OptionParser
	end

	describe "[Hash]" do
		it "can clear" do
			Options[:foo] = :bar
			Options.clear
			Options[].any?.should be_false
		end

		it "can set via []=" do
			Options[@key] = @value
			Options[@key].should eq @value
		end

		it "gets all keys with []" do
			Options[@key] = @value
			Options[].include?(@key).should be_true
		end

		it "gets a value with [:key]" do
			Options[@key] = @value
			Options[@key].should eq @value
		end

		it "can mash values (opposite of merge)." do
			Options[:mash] = 'mush'
			h = {mash:'notmush'}
			Options.mash h
			Options[:mash].should eq 'mush'
		end

		it "Can echo the current version, if asked." do
			Options[:version] = true
			$stdout.should_receive(:puts).with(Bini::VERSION)
			Options.parse!
		end
	end
	describe "parse" do
		it "will attempt to mash in the Config[]#hash if available." do
			Bini::config[@key] == @value
			Options.parse!
			Options[@key] = @value
		end
	end
end
