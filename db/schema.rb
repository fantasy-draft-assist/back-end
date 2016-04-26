ActiveRecord::Schema.define(version: 20160426185151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "auth_token"
    t.string   "favorite_team"
    t.string   "y_access_token"
    t.string   "y_token_type"
    t.datetime "y_expires_at"
    t.string   "y_refresh_token"
    t.string   "xoauth_yahoo_guid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
