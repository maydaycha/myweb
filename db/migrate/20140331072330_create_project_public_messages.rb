class CreateProjectPublicMessages < ActiveRecord::Migration
  def change
    create_table :project_public_messages do |t|
      t.integer :project_id
      t.string :from_user_name
      t.integer :from_user_id
      t.datetime :datetime
      t.text :text
      t.string :attachmentlink

      t.timestamps
    end
  end
end
