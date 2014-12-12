# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(first_name: "Test",
	last_name: "Man",
	username: "tester",
	email: "example@ftest.com",
	password: "123",
	password_confirmation: "123"
	)

99.times do |n|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	username = Faker::Name.username
	email = "example-#{n+1}@ftest.com"
	password = "password"
	User.create!(first_name: first_name,
				 last_name: last_name,
				 username: username,
				 email: email,
				 password: password,
				 password_confirmation: password
				 )
end

#following relationships

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }