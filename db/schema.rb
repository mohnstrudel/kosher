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

ActiveRecord::Schema.define(version: 20171013152005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "barcodes", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bootsy_image_galleries", id: :serial, force: :cascade do |t|
    t.string "bootsy_resource_type"
    t.integer "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", id: :serial, force: :cascade do |t|
    t.string "image_file"
    t.integer "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "logo"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "label_id"
    t.string "slug"
    t.index ["label_id"], name: "index_categories_on_label_id"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "front_image"
    t.string "back_image"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_cities_on_slug", unique: true
  end

  create_table "ckeditor_assets", id: :serial, force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "faqs", id: :serial, force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "general_settings", id: :serial, force: :cascade do |t|
    t.string "url"
    t.string "logo"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "language"
    t.text "address"
    t.hstore "opening_hours"
    t.string "email"
    t.float "long"
    t.float "lat"
    t.string "facebook"
    t.string "title"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "title"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "labels", id: :serial, force: :cascade do |t|
    t.string "logo"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
  end

  create_table "manufacturers", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "logo"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "slug"
    t.boolean "active"
    t.index ["slug"], name: "index_manufacturers_on_slug", unique: true
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "template_id"
  end

  create_table "opening_hours", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "value"
    t.integer "general_setting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.integer "restaurant_id"
    t.index ["general_setting_id"], name: "index_opening_hours_on_general_setting_id"
    t.index ["restaurant_id"], name: "index_opening_hours_on_restaurant_id"
    t.index ["shop_id"], name: "index_opening_hours_on_shop_id"
  end

  create_table "page_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_page_categories_on_slug", unique: true
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page_category_id"
    t.string "slug"
    t.index ["page_category_id"], name: "index_pages_on_page_category_id"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "partners", force: :cascade do |t|
    t.string "title"
    t.string "logo"
    t.string "logo_grey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phones", id: :serial, force: :cascade do |t|
    t.string "value"
    t.integer "general_setting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.integer "restaurant_id"
    t.index ["general_setting_id"], name: "index_phones_on_general_setting_id"
    t.index ["restaurant_id"], name: "index_phones_on_restaurant_id"
    t.index ["shop_id"], name: "index_phones_on_shop_id"
  end

  create_table "pictures", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_translations", id: :serial, force: :cascade do |t|
    t.integer "post_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "body"
    t.index ["locale"], name: "index_post_translations_on_locale"
    t.index ["post_id"], name: "index_post_translations_on_post_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "post_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "logo"
    t.datetime "published_at"
    t.boolean "active"
    t.index ["post_category_id"], name: "index_posts_on_post_category_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "product_barcodes", force: :cascade do |t|
    t.bigint "barcode_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barcode_id"], name: "index_product_barcodes_on_barcode_id"
    t.index ["product_id"], name: "index_product_barcodes_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "label_id"
    t.integer "manufacturer_id"
    t.string "title"
    t.string "description"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "barcode"
    t.string "slug"
    t.boolean "active"
    t.index "lower((description)::text) varchar_pattern_ops", name: "products_lower_description"
    t.index "lower((title)::text) varchar_pattern_ops", name: "products_lower_title"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["label_id"], name: "index_products_on_label_id"
    t.index ["manufacturer_id"], name: "index_products_on_manufacturer_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "recipe_categories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_recipe_categories_on_slug", unique: true
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "amount"
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "logo"
    t.bigint "recipe_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["recipe_category_id"], name: "index_recipes_on_recipe_category_id"
    t.index ["slug"], name: "index_recipes_on_slug", unique: true
  end

  create_table "requests", force: :cascade do |t|
    t.string "name"
    t.string "company_name"
    t.string "email"
    t.string "phone"
    t.string "message"
    t.string "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
  end

  create_table "restaurants", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.string "logo"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "city_id"
    t.string "slug"
    t.index ["city_id"], name: "index_restaurants_on_city_id"
    t.index ["slug"], name: "index_restaurants_on_slug", unique: true
  end

  create_table "seos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keywords", default: [], array: true
    t.bigint "post_id"
    t.bigint "manufacturer_id"
    t.bigint "product_id"
    t.bigint "restaurant_id"
    t.bigint "shop_id"
    t.bigint "city_id"
    t.bigint "recipe_id"
    t.bigint "recipe_category_id"
    t.index ["city_id"], name: "index_seos_on_city_id"
    t.index ["manufacturer_id"], name: "index_seos_on_manufacturer_id"
    t.index ["post_id"], name: "index_seos_on_post_id"
    t.index ["product_id"], name: "index_seos_on_product_id"
    t.index ["recipe_category_id"], name: "index_seos_on_recipe_category_id"
    t.index ["recipe_id"], name: "index_seos_on_recipe_id"
    t.index ["restaurant_id"], name: "index_seos_on_restaurant_id"
    t.index ["shop_id"], name: "index_seos_on_shop_id"
  end

  create_table "shops", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address"
    t.integer "city_id"
    t.string "slug"
    t.index ["city_id"], name: "index_shops_on_city_id"
    t.index ["slug"], name: "index_shops_on_slug", unique: true
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "superadmin"
    t.string "first_name"
    t.string "second_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "labels"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "opening_hours", "general_settings"
  add_foreign_key "opening_hours", "restaurants"
  add_foreign_key "opening_hours", "shops"
  add_foreign_key "pages", "page_categories"
  add_foreign_key "phones", "general_settings"
  add_foreign_key "phones", "restaurants"
  add_foreign_key "phones", "shops"
  add_foreign_key "posts", "post_categories"
  add_foreign_key "product_barcodes", "barcodes"
  add_foreign_key "product_barcodes", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "labels"
  add_foreign_key "products", "manufacturers"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "recipe_categories"
  add_foreign_key "restaurants", "cities"
  add_foreign_key "seos", "cities"
  add_foreign_key "seos", "manufacturers"
  add_foreign_key "seos", "posts"
  add_foreign_key "seos", "products"
  add_foreign_key "seos", "recipe_categories"
  add_foreign_key "seos", "recipes"
  add_foreign_key "seos", "restaurants"
  add_foreign_key "seos", "shops"
  add_foreign_key "shops", "cities"
end
