require 'spec_helper'
class TestClass < Hash
  include Bini::Extensions::HashMetadata
end

describe Bini do
  describe Extensions do
    describe 'HashMetadata' do
      before (:each) do
        @test_hash = {foo:'bar', one:1, two:2}
        @obj = TestClass.new
        @obj.merge!(@test_hash)
        @obj.metadata[:meta_one] = 'dododo'
      end

      it "will supply last_updated automatically"
      it "will not serialize the metadata with the hash." do

        y = YAML.dump @obj
        new_obj = YAML.load y

        new_obj.metadata.should eq({})
      end
    end
  end
end

