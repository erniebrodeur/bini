require 'spec_helper'

describe "FileMagic" do
	it "it will return a ruby mime type when targeting a ruby file." do
		Bini::FileMagic.mime_type("./lib/bini.rb").should eq "text/x-ruby"
	end
  it "will return the version of file if needed" do
    s = Bini::FileMagic.module_exec {filemagic_version}
    `file -v`.include?(s).should be_true
  end
end
