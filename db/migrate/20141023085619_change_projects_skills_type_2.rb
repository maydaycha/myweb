class ChangeProjectsSkillsType2 < ActiveRecord::Migration
	def change
		def up
			change_column :projects, :main_skill, :integer
			change_column :projects, :sub_skill, :integer
		end

		def down
			change_column :projects, :main_skill, :string
			change_column :projects, :sub_skill, :string
		end
	end
end
