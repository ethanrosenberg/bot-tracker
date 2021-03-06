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

ActiveRecord::Schema.define(version: 2020_03_31_061542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "creation_date"
    t.string "handle"
    t.string "profile_image_url"
    t.integer "followers"
    t.integer "tweet_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default_profile_pic"
    t.string "rt_percentage"
    t.integer "retweet_percentage_total"
    t.string "languages", default: [], array: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "keywords", force: :cascade do |t|
    t.string "term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "queries", force: :cascade do |t|
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.bigint "search_id"
    t.bigint "tweet_id"
    t.index ["search_id"], name: "index_queries_on_search_id"
    t.index ["tweet_id"], name: "index_queries_on_tweet_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "tweets_per_day"
    t.boolean "default_profile_pic"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.integer "retweet_percentage"
    t.integer "languages_found"
    t.index ["account_id"], name: "index_reports_on_account_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "results"
    t.integer "percent_finished"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "sleep"
    t.integer "tweets_per_keyword"
    t.integer "tweets_per_timeline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "tweet_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.bigint "user_id"
    t.datetime "profile_created_at"
    t.string "profile_handle"
    t.string "profile_image_url"
    t.integer "followers"
    t.datetime "updated_at", null: false
    t.bigint "query_id"
    t.integer "tweet_count"
    t.string "default_url"
    t.boolean "default_profile_pic"
    t.integer "search_id"
    t.string "language"
    t.index ["query_id"], name: "index_tweets_on_query_id"
  end

  add_foreign_key "queries", "searches"
  add_foreign_key "queries", "tweets"
  add_foreign_key "reports", "accounts"
  add_foreign_key "tweets", "queries"
end
