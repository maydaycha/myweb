class AddCurrencydetialsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :currency_code, :string
    add_column :projects, :currency_exchangerate, :float
  end
end
