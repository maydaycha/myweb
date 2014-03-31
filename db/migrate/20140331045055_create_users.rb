class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :account
      t.string :password
      t.string :country_code
      t.string :city
      t.integer :from
      t.string :how_to_know
      t.boolean :receive_information
      t.integer :siguup_step
      t.integer :pay_per_hour
      t.integer :zip_code
      t.binary :picture
      t.boolean :email_verified
      t.boolean :phone_verified
      t.boolean :payment_verified
      t.integer :type
      t.datetime :last_login_at
      t.string :brief_introduction
      t.text :detailed_introduction

      t.timestamps
    end
  end
end
