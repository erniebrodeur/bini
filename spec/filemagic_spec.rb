require 'spec_helper'

describe "FileMagic" do
	it "it will return a ruby mime type when targeting a ruby file." do
		Bini::FileMagic.mime_type("./lib/bini.rb").should eq "text/x-ruby"
	end
end
