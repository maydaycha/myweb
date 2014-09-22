class AddColumn < ActiveRecord::Migration
  def change
    add_column :projects, :name_chinese, :string
    add_column :projects, :require_skills_chinese, :string
    add_column :projects, :description_chinese, :text
  end
end
