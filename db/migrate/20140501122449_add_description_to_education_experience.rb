class AddDescriptionToEducationExperience < ActiveRecord::Migration
  def change
    add_column :user_educations, :description, :string, :limit => 1000
    add_column :user_experiences, :description, :string, :limit => 1000
  end
end
