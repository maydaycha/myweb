class CreateUserEducations < ActiveRecord::Migration
  def change
    create_table :user_educations do |t|
      t.string :school
      t.string :department
      t.date :strat_date
      t.date :end_date
      t.integer :user_id
      t.timestamps
    end
  end
end
