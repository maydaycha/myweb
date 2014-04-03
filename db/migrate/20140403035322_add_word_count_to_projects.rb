class AddWordCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :word_count, :integer, :default => 0
  end
end
