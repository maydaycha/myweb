class AddTransationDetailToUserTranslaton < ActiveRecord::Migration
  def change
    add_column :user_translations, :description_in_detail, :text
  end
end
