# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Story.destroy_all

10.times do
	user = User.create!(
		:first_name => Faker::Name.first_name,
		:last_name => Faker::Name.last_name,
		:username => Faker::Internet.user_name,
		:email => Faker::Internet.email,
		:password => 'test',
		:password_confirmation => 'test',
		:about_me => Faker::Hacker.say_something_smart,
		:photo => open(Rails.root.join('app', 'assets', 'images', 'avatar.jpg')),
		:home_town => 'Toronto',
		:country => 'Canada'
		#does this work?
	)
	sleep 1
	print "|"
end

#following relationships

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

tags = %w[food money shoes hair travel desk hat goat chair cheese bacon linux mint bitmaker]

20.times do
	owner_id = User.all.sample.id
	s = Story.create!(
	    :title => Faker::Name.title,
	    :owner_id => owner_id,
	    :city => "Anchorage",
	    :state => "Arkansas",
	    :country => "United States",

	    #faker doesn't reliably generate adddresses that can be found on google maps

	)
	sleep 1
	3.times do
		s.tag_list.add(tags.sample)
	end
	s.save

	['sammich.jpeg', 'eye_scream.jpeg', 'boiger.jpg', 'buggy.jpg'].each do |image|
		page = Page.create!(caption: Faker::Company.bs)
		page.page_photo.store!(File.open(Rails.root.join('app', 'assets', 'images', image)))
		s.pages << page
		s.save!
	end
end