# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.destroy_all
Story.destroy_all

50.times do 
	p User.create(
		:first_name => Faker::Name.first_name,
		:last_name => Faker::Name.last_name,
		:username => Faker::Internet.user_name,
		:email => Faker::Internet.email,
		:password => 'test',
		:password_confirmation => 'test'
		#does this work?
	)
end


#following relationships

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }