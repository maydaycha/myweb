class CreateUserPortfolios < ActiveRecord::Migration
  def change
    create_table :user_portfolios do |t|
      t.string :name
      t.string :description
      t.string :path
      t.string :url
      t.date :complete_time
      t.integer :user_skill_category_id
      t.integer :user_skill_id
      t.integer :user_id
      t.timestamps
    end
  end
end
