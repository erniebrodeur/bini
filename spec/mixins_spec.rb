require 'spec_helper'
require 'bini/mixins'

describe "Array#random" do
	it "will return a random entry from the array." do
		a = [1, 2, 3]
		a.include?(a.rand).should be_true
	end
end
