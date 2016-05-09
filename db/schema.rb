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

ActiveRecord::Schema.define(version: 20160509163711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fantasy_players", force: :cascade do |t|
    t.integer  "fantasy_team_id"
    t.string   "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "fantasy_teams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "player_count"
    t.integer  "goalie_count"
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.integer  "team_count"
    t.integer  "player_count"
    t.integer  "goalie_count"
    t.boolean  "games_played",          default: false
    t.boolean  "goals",                 default: false
    t.boolean  "assists",               default: false
    t.boolean  "points",                default: false
    t.boolean  "plus_minus",            default: false
    t.boolean  "penalty_minutes",       default: false
    t.boolean  "powerplay_goals",       default: false
    t.boolean  "powerplay_assists",     default: false
    t.boolean  "powerplay_points",      default: false
    t.boolean  "shorthanded_goals",     default: false
    t.boolean  "shorthanded_assists",   default: false
    t.boolean  "shorthanded_points",    default: false
    t.boolean  "game_winning_goals",    default: false
    t.boolean  "shots_on_goal",         default: false
    t.boolean  "shot_percentage",       default: false
    t.boolean  "faceoffs_won",          default: false
    t.boolean  "faceoffs_lost",         default: false
    t.boolean  "games_started",         default: false
    t.boolean  "wins",                  default: false
    t.boolean  "losses",                default: false
    t.boolean  "goals_against",         default: false
    t.boolean  "goals_against_average", default: false
    t.boolean  "shots_against",         default: false
    t.boolean  "saves",                 default: false
    t.boolean  "save_percentage",       default: false
    t.boolean  "shutouts",              default: false
    t.boolean  "minutes_played",        default: false
    t.boolean  "hits",                  default: false
    t.boolean  "blocks",                default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id"
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
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "yahoo_player_id"
    t.text     "headshot_url"
    t.integer  "uniform_number"
    t.string   "positions",       default: [],              array: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pro_players", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "pro_team_id"
    t.integer  "season"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pro_teams", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.integer  "yahoo_team_id"
    t.text     "logo_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
