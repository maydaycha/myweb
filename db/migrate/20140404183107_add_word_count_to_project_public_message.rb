class AddWordCountToProjectPublicMessage < ActiveRecord::Migration
  def change
    add_column :project_public_messages, :word_count, :integer, :default => 0
  end
end
