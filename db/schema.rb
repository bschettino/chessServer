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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140514181827) do

  create_table "game_over_requests", :force => true do |t|
    t.integer  "game_id"
    t.integer  "winner_id"
    t.integer  "requestor_id"
    t.boolean  "legal"
    t.datetime "validation_time"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "game_players", :force => true do |t|
    t.integer  "player_id"
    t.integer  "game_id"
    t.integer  "checks_count"
    t.string   "player_key"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "winner_id"
    t.integer  "moves_count", :default => 0
    t.boolean  "over",        :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "moves", :force => true do |t|
    t.string   "from",            :limit => 2
    t.string   "to",              :limit => 2
    t.integer  "game_player_id"
    t.boolean  "legal"
    t.datetime "validation_time"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "pieces", :force => true do |t|
    t.integer  "kind"
    t.boolean  "alive",      :default => true
    t.integer  "game_id"
    t.integer  "player_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "squares", :force => true do |t|
    t.integer  "line"
    t.string   "column",     :limit => 1
    t.integer  "game_id"
    t.integer  "piece_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
