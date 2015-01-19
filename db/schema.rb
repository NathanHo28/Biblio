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

ActiveRecord::Schema.define(version: 20150119021324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pages", force: true do |t|
    t.string   "page_photo"
    t.string   "caption"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_number"
  end

  create_table "pins", force: true do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "stories", force: true do |t|
    t.string   "title"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city",                                  null: false
    t.string   "state",                                 null: false
    t.string   "country",                               null: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.decimal  "latitude"
    t.decimal  "longitude"
  end

  add_index "stories", ["cached_votes_down"], name: "index_stories_on_cached_votes_down", using: :btree
  add_index "stories", ["cached_votes_score"], name: "index_stories_on_cached_votes_score", using: :btree
  add_index "stories", ["cached_votes_total"], name: "index_stories_on_cached_votes_total", using: :btree
  add_index "stories", ["cached_votes_up"], name: "index_stories_on_cached_votes_up", using: :btree
  add_index "stories", ["cached_weighted_average"], name: "index_stories_on_cached_weighted_average", using: :btree
  add_index "stories", ["cached_weighted_score"], name: "index_stories_on_cached_weighted_score", using: :btree
  add_index "stories", ["cached_weighted_total"], name: "index_stories_on_cached_weighted_total", using: :btree

  create_table "story_contributors", force: true do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_contributors", ["story_id"], name: "index_story_contributors_on_story_id", using: :btree
  add_index "story_contributors", ["user_id"], name: "index_story_contributors_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",                                   null: false
    t.string   "last_name",                                    null: false
    t.string   "username",                                     null: false
    t.string   "photo",                           default: "", null: false
    t.string   "about_me",                        default: "", null: false
    t.string   "home_town",                       default: "", null: false
    t.string   "email",                                        null: false
    t.string   "crypted_password",                             null: false
    t.string   "salt",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "country"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
