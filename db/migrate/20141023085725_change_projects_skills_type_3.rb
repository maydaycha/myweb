class ChangeProjectsSkillsType3 < ActiveRecord::Migration
	def change
		change_column :projects, :main_skill, :integer
		change_column :projects, :sub_skill, :integer
	end
end
