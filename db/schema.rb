# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_14_115937) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_comments", force: :cascade do |t|
    t.string "ancestry", null: false
    t.integer "creator_id", null: false
    t.integer "post_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_post_comments_on_ancestry"
    t.index ["creator_id"], name: "index_post_comments_on_creator_id"
    t.index ["post_id"], name: "index_post_comments_on_post_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_post_likes_on_creator_id"
    t.index ["post_id"], name: "index_post_likes_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.integer "category_id", null: false
    t.text "body"
    t.integer "creator_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["creator_id"], name: "index_posts_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users", column: "creator_id"
  add_foreign_key "post_likes", "posts"
  add_foreign_key "post_likes", "users", column: "creator_id"
  add_foreign_key "posts", "categories"
  add_foreign_key "posts", "users", column: "creator_id"
end
