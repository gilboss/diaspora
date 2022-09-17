require 'rest-client'
require 'json'

class GithubClient
  
  def initialize
    @api_url = "https://api.github.com"
    @api_token = ENV.fetch("API_TOKEN")
    @authorization = {:Authorization => "token #{@api_token}"}
  end

  def get_user(username)
    response = RestClient.get "#{@api_url}/users/#{username}", @authorization
    JSON.parse(response.body)
  end
  
  def get_followers(username, page = 1, page_size = 100)
    response = RestClient.get "#{@api_url}/users/#{username}/followers?page=#{page}&per_page=#{page_size}", @authorization
    JSON.parse(response.body)
  end
end