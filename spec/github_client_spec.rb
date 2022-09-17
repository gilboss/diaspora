require_relative '../lib/api_client/github_client'

describe "github client" do

  describe "get user" do
    it "get an existig user" do
      user = GithubClient.new.get_user("gilboss")
      puts user
      expect(user).not_to be nil
    end

    it "get user followers" do
      followers = GithubClient.new.get_followers("gilboss")
      expect(followers).not_to be nil
    end
  end
end