#!/usr/bin/ruby
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :bundler do
	watch('Gemfile')

end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('lib/bini/core.rb') { "spec"}
  watch('lib/bini.rb') { "spec" }
  watch('spec/spec_helper.rb')      { "spec" }
end
# group :docs do
#   guard :yard do
#     watch(%r{^lib/(.+)\.rb$})
#   end
# end
