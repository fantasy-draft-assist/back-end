class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :username
    	t.string :password_digest
    	t.string :email
    	t.string :auth_token
    	t.string :favorite_team
    	t.string :y_access_token
    	t.string :y_token_type
    	t.datetime :y_expires_at
    	t.string :y_refresh_token
    	t.string :xoauth_yahoo_guid

      t.timestamps null: false
    end
  end
end
