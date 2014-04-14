class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :user_authentications do |t|
      t.string :user_id, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token
      t.string :token_secret

      t.timestamps
    end
  end
end
