require 'bini'

class TestClass < Hash
  include Bini::Extensions::Savable
end

Bini.long_name = 'boom'

obj = TestClass.new
obj[:foo] = 'bar'
obj.metadata[:savable][:backup] = true
obj.metadata[:savable][:mode] = 0600
puts obj.is_dirty?
puts obj.metadata

require 'pry'
binding.pry
