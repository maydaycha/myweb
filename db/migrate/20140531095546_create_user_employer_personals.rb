class CreateUserEmployerPersonals < ActiveRecord::Migration
  def change
    create_table :user_employer_personals do |t|
      t.integer  "user_id"
      
      t.string "first_name", null: false
      t.string "last_name", null: false
      
	  t.binary "picture", limit: 16777215
	  t.string "brief_introduction"
	  t.string "introduction"
	  t.string "website"
	  t.string "country_code"
	  t.string "city"
	  t.integer "zip"
	  t.string "time_zone", default: "UTC"

      t.timestamps
    end
  end
end
