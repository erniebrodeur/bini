require 'net/http'
require 'net/scp'
require 'uri'
require_relative 'lib/bini/version.rb'
task :default => [:build]

desc "Build the latest version of bini into a gem."

task :build do
	if build_exist?
		puts "Latest build exists in pkg, exiting."
		exit
	end

	puts 'building'
	puts `gem build bini.gemspec`
  FileUtils.mkdir_p 'pkg'
  FileUtils.mv "bini-#{Bini::VERSION}.gem", 'pkg'
end

desc "Push available copies of the gem to gems.ujami.net"
task :release do
	if !build_exist?
		puts "Please build the latest version first."
		exit
	end

	if remote_file_exists? "http://gems.ujami.net/gems/bini-#{Bini::VERSION}.gem"
		puts "Bini #{Bini::VERSION} is already on the remote server."
		exit
	else
		push_file "bini-#{Bini::VERSION}.gem"
	end
end

desc "Tag the current version in git, is destructive."
task :tag do
	if git_dirty?
		puts "Changes left uncommited, exiting."
		exit
	end
	`git tag -a -m \"Version #{Bini::VERSION}\" v#{Bini::VERSION}`

	puts "Tagged the latest version to #{Bini::VERSION}"
end

# Helpers below here.
def build_exist?
	File.exist?("pkg/bini-#{Bini::VERSION}.gem")
end

def git_dirty?
	# That's execute git diff, and return the invert of the result of empty?
	!`git diff`.empty?
end

def push_file(filename)
	puts "Update to: #{filename}"
	puts "Uploading to gems.ujami.net"
	Net::SCP.upload! "gems.ujami.net", "ebrodeur", "pkg/#{filename}", "/tmp/#{filename}"

	Net::SSH.start "gems.ujami.net", "ebrodeur" do |ssh|
		puts ssh.exec "sudo mv /tmp/#{filename} /srv/http/ruby_repo/gems/#{filename}"
		puts "Fixing remote permissions"
		puts ssh.exec "sudo chown -R http.http /srv/http/ruby_repo/*"
		puts "Updating repository on gems.ujami.net"
		puts ssh.exec "sudo -u http gem generate_index -d /srv/http/ruby_repo/"
	end
end

def remote_file_exists?(uri)
	u = URI uri

	response = nil
	Net::HTTP.start(u.host, u.port) do |http|
  	response = http.head(u.path)
	end

	return true if response.code == '200'
	return false
end
