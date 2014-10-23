class ChangeSkillsTypeInProjects < ActiveRecord::Migration
  def change

  	def up
    change_column :projects, :main_skill, :string
  	change_column :projects, :sub_skill, :string
  end

  def down
    change_column :projects, :main_skill, :integer
  	change_column :projects, :sub_skill, :integer
  end
  end
end
