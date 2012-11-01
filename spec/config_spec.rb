require 'spec_helper'

describe "Bini.config" do
	it "is a hash." do
		Bini.config.kind_of?(Hash).should be_true
	end

	it "which responds to save" do
		Bini.config.respond_to?(:save).should be_true
	end

	it "which responds to load" do
		Bini.config.respond_to?(:load).should be_true
	end
end
