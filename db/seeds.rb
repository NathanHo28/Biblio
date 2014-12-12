# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Story.destroy_all

5.times do 
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

50.times do 
	owner_id = [1, 2, 3, 4, 5].sample
	p Story.create!(
	    :title => Faker::Name.title,
	    :owner_id => owner_id,
	    :pages => Page.create(
			[
				{
				:page_photo => open("/Users/NATHAN/wdi-October-2014/final_project/Biblio/sample_photos/sammich.jpeg"),
				:caption => Faker::Company.bs
				},
				{
				:page_photo => open("/Users/NATHAN/wdi-October-2014/final_project/Biblio/sample_photos/eye_scream.jpeg"),
				:caption => Faker::Company.bs
				},
				{
				:page_photo => open("/Users/NATHAN/wdi-October-2014/final_project/Biblio/sample_photos/boiger.jpg"),
				:caption => Faker::Company.bs
				},
				{
				:page_photo => open("/Users/NATHAN/wdi-October-2014/final_project/Biblio/sample_photos/buggy.jpg"),
				:caption => Faker::Company.bs
				}
			]
		)
	)
end