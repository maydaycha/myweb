class ChangeBudgetColumn < ActiveRecord::Migration
  def change
    change_column :projects, :budget,  :string
  end
end
