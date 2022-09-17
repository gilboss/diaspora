require_relative '../lib/storage/storage_file'

describe "storage file" do

  describe "create user" do
    it "create a new user" do
      user = StorageFile.new.create_user({user: "gilboss_test_x", followers: ["uno", "dos", "tres"]})
      puts user
      expect(user).not_to be nil
    end

    it "read user file" do
      followers = StorageFile.new.find_full_user_followers("gilboss_test_x").map(&:chomp)
      puts "#{followers}"
      expect(followers).not_to be nil
    end
  end
end