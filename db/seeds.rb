# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# for user
NB_EMPLOYER = 2
NB_USERS = 10
NB_PROJECTS = 10
NB_MEMBER = 3



NB_MEMBER.times do |n|
	ProjectMember.create! do |a|
		a.user_id = n + 4
		a.project_id = 1
	end
end


