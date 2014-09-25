class AddMainSkillAndSubSkillToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :main_skill, :string
  	add_column :projects, :sub_skill, :string
  end
end
