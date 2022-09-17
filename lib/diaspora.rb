require_relative 'services/user_service'

@first_user = "carlogilmar"
@second_user = "neodevelop"
@user_service = UserService.new

common_followers = @user_service.common_followers(@first_user, @second_user)

puts "common followers #{@first_user} and #{@second_user}"
puts "#{common_followers}"

followers_combination = common_followers.combination(2)

followers_relation = followers_combination.map do | follower_pair |
  relation_follower_pair = @user_service.relation_followers(follower_pair[0], follower_pair[1])
  {
    first_follower: follower_pair[0],
    second_follower: follower_pair[1],
    follow_eachother?: relation_follower_pair,
  }
end

followers_relation.sort_by do | relation |
  relation.fetch(:follow_eachother?) ? 0 : 1
end

followers_relation.each do | relation |
  puts "follow eachother: #{relation.fetch(:follow_eachother?)} #{relation.fetch(:first_follower)} - #{relation.fetch(:second_follower)}"
end