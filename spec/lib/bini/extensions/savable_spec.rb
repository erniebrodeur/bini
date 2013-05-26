require 'spec_helper'

class TestClass < Hash
  include Bini::Extensions::Savable
end

describe Bini::Extensions::Savable do
  before (:each) do
    Bini.config_dir = "tmp/"
    Bini.long_name = "savable_test"
    @obj = TestClass.new
  end

  it "will (auto)save" do
    @obj[:foo] = 'bar'
    @obj.save
    @obj.clear
    @obj.should eq({})
    @obj.load
    @obj[:foo].should eq 'bar'
    @obj.options[:autosave] = true
    @obj[:fooboo] = 'bar2'
    @obj.clear
    @obj.load
    @obj[:fooboo].should eq 'bar2'
  end

  it "will know when it needs to save" do
    @obj[:dirttty] = 'twue'
    @obj.is_dirty?.should be_true
    @obj.save
    @obj.is_dirty?.should be_false
  end

  it "will generate a backup on request" do
    @obj.options[:backup] = true
    @obj[:back] = 'bbbb'
    @obj.save
    File.exists?(@obj.backup_file).should be_true
  end
  it "will set mode on request" do
    @obj.options[:mode] = 0600
    @obj[:m] == 'mmm'
    @obj.save
    # According to the docs, this is likely platform dependent.  Need a mac
    # to test.
    File.stat(@obj.options[:file]).mode.should eq 0100600
  end
  it "will clean up after itself if requested" do
    @obj[:too] = 'foo'
    @obj.save
    @obj.clean_files
    File.exist?(@obj.options[:file]).should be_false
    File.exist?(@obj.backup_file).should be_false
  end
end
