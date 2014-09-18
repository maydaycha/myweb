class CreateProjectQuestions < ActiveRecord::Migration
  def change
    create_table :project_questions do |t|
      t.string "description"
      t.timestamps
    end
  end
end
