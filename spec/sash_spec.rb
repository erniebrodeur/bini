require 'bini/sash'

include Bini

describe "Sash" do
	def random_file
		"tmp/sash-#{Random.rand(0..10000000).to_s(16)}.yaml"
	end

	before (:all) do
		FileUtils.mkdir_p 'tmp'
	end

	before (:each) do
		@filename = random_file
		@s = Sash.new file:@filename
		@s[:before_each] = true
	end

	after (:all) do
		Dir.glob("tmp/sash-*.yaml*").each { |f| FileUtils.rm f}
	end

	it "can select the filename" do
		@s.file.should be @filename
	end

	it "can save" do
		@s[:foo] = :bar
		@s.save
		@s2 = Sash.new file:@filename
		@s2.load
		@s2[:foo].should eq :bar
	end
	it "can set the mode" do
		@s.mode = 0600
		@s.set_mode
		@s.save
		# I have no idea why you put in 0600, 0600 becomes 384, and out comes 33152.
		# when I figure out where the conversion is going wrong, I'll update this.
		File.stat(@s.file).mode.should eq 33152
	end

	it "can auto save" do
		@s = Sash.new file:@filename, auto_save:true
		@s[:auto_save] = true
		@s2 = Sash.new file:@filename
		@s2.load
		@s2[:auto_save].should be true
	end

	it "can auto load" do
		@s[:auto_load] = true
		@s.save
		@s2 = Sash.new file:@filename, auto_load:true
		@s2[:auto_load].should be true
	end

	# We save twice because in order to produce a backup file, we need an original.
	it "can make a backup file" do
		@s.backup = true
		@s[:backup] = "something"
		@s.save
		@s.save
		File.exist?(@s.backup_file).should be_true
	end

	it "will behave like a normal Hash" do
		@s.kind_of?(Hash).should be_true
	end

	it "will clear before load, destroying previous contents" do
		@s[:clear] = 'clear'
		@s.load
		@s[:clear].should be_nil
	end
end

