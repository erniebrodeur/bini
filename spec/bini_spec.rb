require 'spec_helper'

describe "Bini" do
	before (:each) do
		Bini.long_name = nil
		@long_name = Bini.long_name
		Bini.cache_dir = nil
		Bini.config_dir = nil
	end

	describe "long_name" do
		it "can be reset" do
			Bini.long_name = nil
			Bini.long_name.should eq @long_name
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
	end

	it "can be configured via .configure" do
		r = random_hex 4
		Bini.configure do |c|
			c.long_name = r
		end
		Bini.long_name.should eq r
	end
end
