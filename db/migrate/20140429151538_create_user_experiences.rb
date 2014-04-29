class CreateUserExperiences < ActiveRecord::Migration
  def change
    create_table :user_experiences do |t|
      t.string :organization
      t.string :office
      t.date :start_date
      t.date :end_date
      t.integer :user_id
      t.timestamps
    end
  end
end
