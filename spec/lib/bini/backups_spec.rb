require 'spec_helper.rb'

# Tweakables as needed (though not bloody likely)
BACKUP_FILE = "tmp/backup_input"
BACKUP_HEX = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
BACKUP_INDEX = "tmp/backup.json"

describe Bini::Backups do
  before (:all) do
    Bini.backup_dir = 'tmp/backups'
    generate_testfile BACKUP_FILE
  end

  before (:each) do
    @backup = Bini::Backups.new index_file:BACKUP_INDEX
  end

  after(:all) do
    FileUtils.rm BACKUP_FILE
    FileUtils.rm BACKUP_INDEX
    FileUtils.rm "#{BACKUP_INDEX}.bak" if File.exists? "#{BACKUP_INDEX}.bak"
    FileUtils.rm_rf Bini.backup_dir
  end

  describe "index" do
    it "the key will be a sha256 of the file contents" do
      @backup.generate_key(BACKUP_FILE).should eq BACKUP_HEX
    end
    it "will return a hex if given a filename"
  end

  describe "Bini::Backups.store" do
    it "will add a file to the index" do
      @backup.store BACKUP_FILE
    end

    it "will fail if the one file has two hex sums"

    it "will copy the file into the backups" do
      File.exists?("#{Bini.backup_dir}/#{BACKUP_HEX}").should be_true
    end
  end

  describe "restore" do
    it "Will remove the file from the index"
    it "will copy the file to the restore point"
    it "will fail if a file is already there and not the same md5sum"

    describe "last entry" do
      it "will clean up the backup dir"
      it "will remove the index entry as needed"
    end
  end
end


def generate_testfile(file)
  open(file, 'w').write('gibberish') if !File.exists? file
end
