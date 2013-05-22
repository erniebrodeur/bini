require 'bini'

class TestClass < Hash
  include Bini::Extensions::Savable
end

Bini.long_name = 'boom'

obj = TestClass.new
obj[:foo] = 'bar'

puts obj.is_dirty?
puts obj.metadata

require 'pry'
binding.pry
