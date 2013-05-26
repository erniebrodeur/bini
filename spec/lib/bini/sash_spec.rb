require 'spec_helper'

describe Bini::Sash do
	before (:each) do
		@filename = "tmp/sash_savefile.yaml"
		@s = Bini::Sash.new options:{file:@filename}
		@s[:before_each] = true
	end

	it "Can pass overrides via overrides:{}" do
		@s2 = Bini::Sash.new(overrides:{foo: :bar})
		@s2.should  include(:foo)
	end

	it 'will fail gracefully if nothing to load.' do
		@s.save
		FileUtils.rm @filename
		@s.load.should eq({})
		@s.options[:file] = nil
		@s.load.should eq({})
		FileUtils.touch @filename
		@s.load.should eq({})
	end
	it "will raise an exception if you pass in unknown arguments to new." do
		@s2 = expect { Sash.new(foo:'bar') }.to raise_error
	end

	it "can auto load" do
		@s[:autoload] = true
		@s.save
		@s2 = Bini::Sash.new options:{file:@filename, autoload:true}
		@s2[:autoload].should be_true
	end
end
