class ChangeDataTypeForYAccessTokenInUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.change :y_access_token, :text
  	end
  end
end
