class ChangSkillTypeUser < ActiveRecord::Migration
  def change
    change_column :users, :skill, :string
  end
end
