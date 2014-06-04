class DeleteColumnUser < ActiveRecord::Migration
  def change
    remove_column :users, :sketch, :string
  end
end
