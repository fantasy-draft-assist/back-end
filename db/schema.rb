# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160502202818) do

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

  create_table "player_stats", force: :cascade do |t|
    t.integer  "pro_player_id"
    t.integer  "games_played"
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "points"
    t.integer  "plus_minus"
    t.integer  "penalty_minutes"
    t.integer  "powerplay_goals"
    t.integer  "powerplay_assists"
    t.integer  "powerplay_points"
    t.integer  "shorthanded_goals"
    t.integer  "shorthanded_assists"
    t.integer  "shorthanded_points"
    t.integer  "game_winning_goals"
    t.integer  "game_tying_goals"
    t.integer  "shots_on_goal"
    t.float    "shot_percentage"
    t.integer  "faceoffs_won"
    t.integer  "faceoffs_lost"
    t.integer  "games_started"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "goals_against"
    t.float    "goals_against_average"
    t.integer  "shots_against"
    t.integer  "saves"
    t.float    "save_percentage"
    t.integer  "shutouts"
    t.integer  "minutes_played"
    t.integer  "hits"
    t.integer  "blocks"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "player_name"
    t.integer  "yahoo_player_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pro_players", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "pro_team_id"
    t.integer  "season"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
