require 'spec_helper'

describe "Bini.config" do
	it "is a hash." do
		Bini::Config.kind_of?(Hash).should be_true
	end

	it "which responds to save" do
		Bini::Config.respond_to?(:save).should be_true
	end

	it "which responds to load" do
		Bini::Config.respond_to?(:load).should be_true
	end
end
