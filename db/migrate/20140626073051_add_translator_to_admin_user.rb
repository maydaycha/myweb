class AddTranslatorToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :is_translator, :boolean, :default => false
  end
end
