module ErnieBrodeur
	module NextBackground
		def add_directory(dir)
			Dir.glob("#{dir}**/*").each do |file|
				add_file file
			end
		end

		def add_file(file)
			# does it exist in the data base? if so return it
			if (f = ErnieBrodeur::Models::Image.find(file))
				puts "File existed: #{file}"
				return f
			end
			# Is our file an image?  if not, just return nil.
			return nil if !ErnieBrodeur::is_image?(file)
			puts "Adding file: #{file}"
			begin
				ErnieBrodeur::Models::Image.create!(:filename => file, :md5sum => true)
			rescue
			end
		end

		def run_once
		end

		def output_file
		end

		def daemonize
		end
	end
end
