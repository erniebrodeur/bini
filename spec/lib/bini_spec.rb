require 'spec_helper'

# I'm not 100% sure/convinvced any of these do what I think they do.
describe "Bini" do
	before (:each) do
		Bini.long_name = nil
		@long_name = Bini.long_name
		Bini.cache_dir = nil
		@cache_dir = Bini.cache_dir
		Bini.config_dir = nil
		@config_dir = Bini.config_dir
		Bini.version = nil
	end

	describe "parameters?" do
		it 'will return true only if everything is true.' do
			Bini.long_name = "tmp/test"
			Bini.parameters?.should be_false
			Bini.cache_dir = "tmp/here"
			Bini.config_dir = "tmp/there"
			Bini.parameters?.should be_true
		end
	end

	# Dynamically generate our key tests, more for fun then any real need.
	Bini.keys.each do |key|
		describe "#{key}" do
			it "can be reset to a default" do
				Bini.send "#{key}=", nil
				Bini.send(key).should eq Bini.defaults[key]
			end
			it "can be overriden" do
				r = random_hex 16
				Bini.send "#{key}=", r
				Bini.send(key).should eq r
			end

			it "can be configured via .configure" do
				r = random_hex 4
				Bini.configure do |c|
					c.instance_variable_set "@#{key}", r
				end
				Bini.send(key).should eq r
			end
		end
	end

	Bini.version
end

