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

ActiveRecord::Schema.define(version: 20180227022946) do

  create_table "activities", force: :cascade do |t|
    t.integer "user_id_id"
    t.integer "target_id"
    t.string "action_type"
    t.string "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id_id"], name: "index_activities_on_user_id_id"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "word_id_id"
    t.boolean "is_correct"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id_id"], name: "index_answers_on_word_id_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "user_id_id"
    t.integer "category_id_id"
    t.boolean "is_finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id_id"], name: "index_lessons_on_category_id_id"
    t.index ["user_id_id"], name: "index_lessons_on_user_id_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "word_id_id"
    t.integer "lesson_id_id"
    t.integer "answer_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id_id"], name: "index_results_on_answer_id_id"
    t.index ["lesson_id_id"], name: "index_results_on_lesson_id_id"
    t.index ["word_id_id"], name: "index_results_on_word_id_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 80
    t.string "name", limit: 20
    t.string "avatar"
    t.string "adress", limit: 120
    t.boolean "is_admin", default: false
    t.string "password_digest", limit: 120
    t.string "remember_digest", limit: 120
    t.string "activation_digest", limit: 120
    t.boolean "activated"
    t.datetime "activated_at"
    t.string "reset_digest", limit: 120
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "words", force: :cascade do |t|
    t.integer "category_id_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id_id"], name: "index_words_on_category_id_id"
  end

end
