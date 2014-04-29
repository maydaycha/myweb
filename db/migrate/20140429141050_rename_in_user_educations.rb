class RenameInUserEducations < ActiveRecord::Migration
  def change
    rename_column :user_educations, :strat_date, :start_date
  end
end
