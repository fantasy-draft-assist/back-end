ActiveRecord::Schema.define(version: 20160427200323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drafts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "team_id_1"
    t.integer  "team_id_2"
    t.integer  "team_id_3"
    t.integer  "team_id_4"
    t.integer  "team_id_5"
    t.integer  "team_id_6"
    t.integer  "team_id_7"
    t.integer  "team_id_8"
    t.integer  "team_id_9"
    t.integer  "team_id_10"
    t.integer  "team_id_11"
    t.integer  "team_id_12"
    t.integer  "team_id_13"
    t.integer  "team_id_14"
    t.integer  "team_id_15"
    t.integer  "team_id_16"
    t.integer  "team_id_17"
    t.integer  "team_id_18"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "player_name"
    t.integer  "yahoo_player_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.integer  "year"
    t.integer  "yahoo_league_id"
    t.integer  "yahoo_game_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "player_id_1"
    t.integer  "player_id_2"
    t.integer  "player_id_3"
    t.integer  "player_id_4"
    t.integer  "player_id_5"
    t.integer  "player_id_6"
    t.integer  "player_id_7"
    t.integer  "player_id_8"
    t.integer  "player_id_9"
    t.integer  "player_id_10"
    t.integer  "player_id_11"
    t.integer  "player_id_12"
    t.integer  "player_id_13"
    t.integer  "player_id_14"
    t.integer  "player_id_15"
    t.integer  "player_id_16"
    t.integer  "player_id_17"
    t.integer  "player_id_18"
    t.integer  "player_id_19"
    t.integer  "player_id_20"
    t.integer  "player_id_21"
    t.integer  "player_id_22"
    t.integer  "player_id_23"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "auth_token"
    t.string   "favorite_team"
    t.text     "y_access_token"
    t.string   "y_token_type"
    t.datetime "y_expires_at"
    t.string   "y_refresh_token"
    t.string   "xoauth_yahoo_guid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
