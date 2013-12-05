class InitMigration < ActiveRecord::Migration
  def change

    create_table "posts", force: true do |t|
      t.text     "content"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
    end

    add_index "posts", ["user_id"]

    create_table "users", force: true do |t|
      t.string   "username"
      t.string   "email", null: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

end
