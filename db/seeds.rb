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
	p User.create!(
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

50.times do 
	owner_id = User.all.sample.id
	s = Story.create!(
	    :title => Faker::Name.title,
	    :owner_id => owner_id
	)

	['sammich.jpeg', 'eye_scream.jpeg', 'boiger.jpg', 'buggy.jpg'].each do |image|
		page = Page.create!(caption: Faker::Company.bs)
		page.page_photo.store!(File.open(Rails.root.join('app', 'assets', 'images', image)))
		s.pages << page
		s.save!
	end
end