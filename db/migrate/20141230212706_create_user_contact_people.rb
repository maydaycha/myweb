class CreateUserContactPeople < ActiveRecord::Migration
  def change
    create_table :user_contact_people do |t|
    	t.integer :contact_person
    	t.string :contact_person_name
    	t.integer :project_id
    	t.string :project_name
    	t.integer :interview_time
    	t.integer :contact_type

      t.timestamps
    end
  end
end
