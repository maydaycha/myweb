class RemoveCountryCodeNotNull < ActiveRecord::Migration
  def change
  	change_column :users, :country_code, :string, :null => true
  end
end
