# A mixin for [Array]
class Array
  # Return a random element from the Array.
	def rand
		self[Random.rand(self.count)]
	end
end
