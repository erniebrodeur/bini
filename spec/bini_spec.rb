require 'spec_helper'

# I'm not 100% sure convinvced any of these do what I think they do.
describe "Bini" do
	before (:each) do
		Bini.long_name = nil
		@long_name = Bini.long_name
		Bini.cache_dir = nil
		@cache_dir = Bini.cache_dir
		Bini.config_dir = nil
		@config_dir = Bini.config_dir
	end

	# I can probably do this dynamically.
	describe "long_name" do
		it "can be reset" do
			Bini.long_name = nil
			Bini.long_name.should eq Bini.defaults[:long_name]
		end

		it "provides a default" do
			Bini.long_name = nil
			Bini.long_name.should_not be_nil
		end

		it "can be overridden" do
			r = random_hex 4
			Bini.long_name = r
			Bini.long_name.should eq r
		end

		it "can be configured via .configure" do
			r = random_hex 4
			Bini.configure do |c|
				c.long_name = r
			end
			Bini.long_name.should eq r
		end
	end

	describe "cache_dir" do
		it "can be reset" do
			Bini.cache_dir = nil
			Bini.cache_dir.should eq @cache_dir
		end


		it "provides a default" do
			Bini.cache_dir = nil
			Bini.cache_dir.should_not be_nil
		end

		it "can be overridden" do
			r = random_hex 4
			Bini.cache_dir = r
			Bini.cache_dir.should eq r
		end
		it "can be configured via .configure" do
			r = random_hex 4
			Bini.configure do |c|
				c.cache_dir = r
			end
			Bini.cache_dir.should eq r
		end
	end
	describe "config_dir" do
		it "can be reset" do
			Bini.config_dir = nil
			Bini.config_dir.should eq @config_dir
		end


		it "provides a default" do
			Bini.config_dir = nil
			Bini.config_dir.should_not be_nil
		end

		it "can be overridden" do
			r = random_hex 4
			Bini.config_dir = r
			Bini.config_dir.should eq r
		end
		it "can be configured via .configure" do
			r = random_hex 4
			Bini.configure do |c|
				c.config_dir = r
			end
			Bini.config_dir.should eq r
		end
	end
end

