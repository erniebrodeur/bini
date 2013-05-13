require 'spec_helper.rb'

# Tweakables as needed (though not bloody likely)
BACKUP_FILE = "tmp/backup_input"
BACKUP_HEX = "bbe571c8b767d648b65419743dfe851def6f85469edb934e7bf79b2c99765589"
BACKUP_INDEX = "tmp/backup.json"

describe "Bini::Backups" do
  before (:all) do
    Bini.backup_dir = 'tmp/backups'
    generate_testfile
    @backup = Bini::Backups.new index_file:BACKUP_INDEX, auto_load:true
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

    it "will store the mode in the index"

    it "will copy the file into the backups" do
      File.exists?("#{Bini.backup_dir}/#{BACKUP_HEX}").should be_true
    end
  end

  describe "restore" do
    before(:each) do
      @backup = Bini::Backups.new index_file:BACKUP_INDEX, auto_load:true
      FileUtils.rm BACKUP_FILE if BACKUP_FILE
      @backup.restore BACKUP_FILE
    end

    it "Will remove the file from the index" do
      @backup.index[BACKUP_HEX].should be_nil
    end

    it "will restore the proper mode on the file"

    it "will copy the file to the restore point" do
      File.exists?(BACKUP_FILE).should be_true
    end

    it "will fail if a file is already there and not the same md5sum"

    describe "last entry" do
      it "will clean up the backup dir"
      it "will remove the index entry as needed"
    end
  end

  after(:all) do
    cleanup_files
  end
end


def cleanup_files
  FileUtils.rm_rf "tmp/backup*"
end

def generate_testfile
  unless File.exists? BACKUP_FILE
    # so ruby wants to be clever, I want a file with goddamn output.
    file = open(BACKUP_FILE, 'w')
    file.write 'gibberish'
    file.sync
    file.close
  end
end
