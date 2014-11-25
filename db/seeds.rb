# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# for user
NB_USERS = 10
NB_PROJECTS = 10

NB_USERS.times do |n|
	User.create! do |a|
	  a.email = Faker::Internet.email.gsub('@', "#{n}@")
	  a.password = a.password_confirmation = 'password'
	  a.sign_in_count = 0
	  a.failed_attempts = 0
	  a.username = Faker::Name.name + n.to_s
	  a.first_name = Faker::Name.first_name
	  a.last_name = Faker::Name.last_name
	  a.confirmed_at = Faker::Date.between(1.days.ago, Date.today)
	end
end


NB_PROJECTS.times do |n|
	Project.create! do |a|
	  a.name = 'project' + '-' + n.to_s
	end
end



