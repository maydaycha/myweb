class AddStepToUsers < ActiveRecord::Migration
  def change
    add_column :users, :step, :integer
  end
end
