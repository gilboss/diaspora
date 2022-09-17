
class StorageFile
  def initialize
    @folder_path = "followers_files"
    Dir.mkdir(@folder_path) unless File.exists?(@folder_path)
  end

  def create_user(user)
    File.open("#{@folder_path}/#{user.fetch(:user)}.txt", "w") do |file| 
      user.fetch(:followers).each do | follower |
        file.write("#{follower}\n")
      end
    end
  end

  def find_full_user_followers(username)
    File.open("#{@folder_path}/#{username}.txt", "r").readlines()
  end

  def find_user_with_followers(username)
    if File.file?("#{@folder_path}/#{username}.txt")
      return {
        user: username,
        followers: find_full_user_followers(username).map(&:chomp)
      }
    end
    return nil
  end
  
end