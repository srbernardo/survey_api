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

ActiveRecord::Schema[7.1].define(version: 2024_09_05_124814) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choice_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "choice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_choice_answers_on_choice_id"
    t.index ["user_id"], name: "index_choice_answers_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "multi_line_answers", force: :cascade do |t|
    t.text "value", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_multi_line_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.integer "option", null: false
    t.integer "order", null: false
    t.bigint "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "single_line_answers", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_single_line_answers_on_question_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "open", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "choice_answers", "choices"
  add_foreign_key "choice_answers", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "multi_line_answers", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "single_line_answers", "questions"
  add_foreign_key "surveys", "users"
end
