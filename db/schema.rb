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

ActiveRecord::Schema.define(version: 20170330165334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "logo"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "front_image"
    t.string   "back_image"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "faqs", force: :cascade do |t|
    t.string   "question"
    t.text     "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "general_settings", force: :cascade do |t|
    t.string   "url"
    t.string   "logo"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.hstore   "language"
    t.text     "address"
    t.hstore   "opening_hours"
    t.string   "email"
    t.float    "long"
    t.float    "lat"
  end

  create_table "kosher_lone_labels", force: :cascade do |t|
    t.string   "logo"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "kosher_ltwo_labels", force: :cascade do |t|
    t.string   "logo"
    t.string   "title"
    t.text     "description"
    t.integer  "kosher_lone_label_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["kosher_lone_label_id"], name: "index_kosher_ltwo_labels_on_kosher_lone_label_id", using: :btree
  end

  create_table "labels", force: :cascade do |t|
    t.string   "logo"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "parent_id"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "logo"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "opening_hours", force: :cascade do |t|
    t.string   "title"
    t.string   "value"
    t.integer  "general_setting_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "shop_id"
    t.integer  "restaurant_id"
    t.index ["general_setting_id"], name: "index_opening_hours_on_general_setting_id", using: :btree
    t.index ["restaurant_id"], name: "index_opening_hours_on_restaurant_id", using: :btree
    t.index ["shop_id"], name: "index_opening_hours_on_shop_id", using: :btree
  end

  create_table "page_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["slug"], name: "index_page_categories_on_slug", unique: true, using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "page_category_id"
    t.string   "slug"
    t.index ["page_category_id"], name: "index_pages_on_page_category_id", using: :btree
    t.index ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
  end

  create_table "phones", force: :cascade do |t|
    t.string   "value"
    t.integer  "general_setting_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "shop_id"
    t.integer  "restaurant_id"
    t.index ["general_setting_id"], name: "index_phones_on_general_setting_id", using: :btree
    t.index ["restaurant_id"], name: "index_phones_on_restaurant_id", using: :btree
    t.index ["shop_id"], name: "index_phones_on_shop_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "post_categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_translations", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.text     "body"
    t.index ["locale"], name: "index_post_translations_on_locale", using: :btree
    t.index ["post_id"], name: "index_post_translations_on_post_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "post_category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug"
    t.index ["post_category_id"], name: "index_posts_on_post_category_id", using: :btree
    t.index ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "label_id"
    t.integer  "manufacturer_id"
    t.string   "title"
    t.string   "description"
    t.string   "logo"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
    t.index ["label_id"], name: "index_products_on_label_id", using: :btree
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "logo"
    t.text     "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "logo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "address"
  end

  create_table "sublabels", force: :cascade do |t|
    t.string   "logo"
    t.string   "title"
    t.text     "description"
    t.integer  "label_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["label_id"], name: "index_sublabels_on_label_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "superadmin"
    t.string   "first_name"
    t.string   "second_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "kosher_ltwo_labels", "kosher_lone_labels"
  add_foreign_key "opening_hours", "general_settings"
  add_foreign_key "opening_hours", "restaurants"
  add_foreign_key "opening_hours", "shops"
  add_foreign_key "pages", "page_categories"
  add_foreign_key "phones", "general_settings"
  add_foreign_key "phones", "restaurants"
  add_foreign_key "phones", "shops"
  add_foreign_key "posts", "post_categories"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "labels"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "sublabels", "labels"
end
