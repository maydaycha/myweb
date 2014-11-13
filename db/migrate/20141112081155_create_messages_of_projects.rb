class CreateMessagesOfProjects < ActiveRecord::Migration
  def change
    create_table :messages_of_projects do |t|
      t.integer :project_id
      t.text :body
      t.timestamps
    end
  end
end
