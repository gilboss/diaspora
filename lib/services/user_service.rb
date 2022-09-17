require_relative '../api_client/github_client'
require_relative '../storage/storage_file'
require_relative '../helpers/user_helper'

class UserService

  def initialize
    @storage_file = StorageFile.new
    @github_client = GithubClient.new
    @user_helper = UserHelper.new
    @page_size = 100
  end

  def followers_list(username, page = 1)
    user = @storage_file.find_user_with_followers(username)
    if user == nil
      puts "get user and followers from github api of #{username}"
      user = self.remote_full_user(username)
      @storage_file.create_user(user)
    end
    user.fetch(:followers)
  end

  def remote_full_user(username) 
    {
      user: self.remote_user(username),
      followers: self.remote_followers(username)
    }
  end

  def remote_user(username)
    user = @github_client.get_user(username)
    user.fetch("login")
  end

  def remote_followers(username)
    total_followers = @github_client.get_user(username).fetch("followers")
    total_pages = @user_helper.total_pages(total_followers, @page_size)
    (1..total_pages).inject([]) do |acc, page|
      acc + @github_client.get_followers(username, page, @page_size).map{ | follower | follower.fetch("login") }
    end
  end

  def common_followers(first_user, second_user)
    first_user_followers = self.followers_list(first_user)
    second_user_followers = self.followers_list(second_user)
    
    first_user_followers & second_user_followers
  end

  def relation_followers(first_user, second_user)
    first_user_followers = self.followers_list(first_user)
    second_user_followers = self.followers_list(second_user)
  
    first_user_followers.include?(second_user) && second_user_followers.include?(first_user)
  end
end