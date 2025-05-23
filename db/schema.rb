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

ActiveRecord::Schema[8.0].define(version: 2025_05_12_145851) do
  create_table "dummies", force: :cascade do |t|
    t.string "dummy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_genres_on_code"
    t.index ["name"], name: "index_genres_on_name"
  end

  create_table "genres_songs", id: false, force: :cascade do |t|
    t.integer "song_id", null: false
    t.integer "genre_id", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "year"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imdb_key"
    t.index ["code"], name: "index_movies_on_code"
    t.index ["name"], name: "index_movies_on_name"
    t.index ["year"], name: "index_movies_on_year"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_organizations_on_code"
    t.index ["name"], name: "index_organizations_on_name"
  end

  create_table "organizations_songs", id: false, force: :cascade do |t|
    t.integer "song_id", null: false
    t.integer "organization_id", null: false
  end

  create_table "performers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_performers_on_code"
    t.index ["name"], name: "index_performers_on_name"
  end

  create_table "performers_song_plays", id: false, force: :cascade do |t|
    t.integer "performer_id", null: false
    t.integer "song_play_id", null: false
  end

  create_table "performers_songs", id: false, force: :cascade do |t|
    t.integer "song_id", null: false
    t.integer "performer_id", null: false
  end

  create_table "song_plays", force: :cascade do |t|
    t.string "code"
    t.string "youtube_key"
    t.string "url"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "song_id"
    t.index ["code"], name: "index_song_plays_on_code"
    t.index ["song_id"], name: "index_song_plays_on_song_id"
    t.index ["url"], name: "index_song_plays_on_url"
    t.index ["youtube_key"], name: "index_song_plays_on_youtube_key"
  end

  create_table "songs", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "movie_id"
    t.index ["code"], name: "index_songs_on_code"
    t.index ["movie_id"], name: "index_songs_on_movie_id"
    t.index ["name"], name: "index_songs_on_name"
  end

  create_table "songs_writers", id: false, force: :cascade do |t|
    t.integer "song_id", null: false
    t.integer "writer_id", null: false
  end

  create_table "writers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_writers_on_code"
    t.index ["name"], name: "index_writers_on_name"
  end

  add_foreign_key "song_plays", "songs"
end
