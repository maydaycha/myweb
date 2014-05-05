class CreateUserCertifications < ActiveRecord::Migration
  def change
    create_table :user_certifications do |t|
        t.string :name
        t.string :source
        t.string :link
        t.string :get_time
        t.string :description, :limit => 1000
        t.integer :user_id
        t.timestamps
    end
end
end
