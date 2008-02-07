# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 21) do

  create_table "aggregation_feeds", :force => true do |t|
    t.integer "aggregation_id"
    t.integer "feed_id"
  end

  add_index "aggregation_feeds", ["aggregation_id"], :name => "index_aggregation_feeds_on_aggregation_id"
  add_index "aggregation_feeds", ["feed_id"], :name => "index_aggregation_feeds_on_feed_id"

  create_table "aggregation_top_tags", :force => true do |t|
    t.integer "aggregation_id", :default => 0
    t.integer "tag_id"
    t.integer "hits"
  end

  add_index "aggregation_top_tags", ["aggregation_id"], :name => "index_aggregation_top_tags_on_aggregation_id"
  add_index "aggregation_top_tags", ["tag_id"], :name => "index_aggregation_top_tags_on_tag_id"

  create_table "aggregations", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.text     "top_tags"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aggregations", ["user_id"], :name => "index_aggregations_on_user_id"

  create_table "entries", :force => true do |t|
    t.integer  "feed_id",                                                  :null => false
    t.string   "permalink",             :limit => 2083, :default => "",    :null => false
    t.string   "author",                :limit => 2083
    t.text     "title",                                                    :null => false
    t.text     "description",                           :default => "",    :null => false
    t.text     "content",                               :default => "",    :null => false
    t.boolean  "unique_content",                        :default => false
    t.text     "tag_list"
    t.datetime "published_at",                                             :null => false
    t.datetime "entry_updated_at"
    t.datetime "harvested_at"
    t.string   "oai_identifier",        :limit => 2083
    t.text     "related_entries"
    t.boolean  "recommender_processed",                 :default => false
    t.string   "language"
  end

  add_index "entries", ["feed_id"], :name => "index_entries_on_feed_id"
  add_index "entries", ["language"], :name => "index_entries_on_language"
  add_index "entries", ["oai_identifier"], :name => "index_entries_on_oai_identifier"
  add_index "entries", ["permalink"], :name => "index_entries_on_permalink"
  add_index "entries", ["published_at"], :name => "index_entries_on_published_at"
  add_index "entries", ["recommender_processed"], :name => "index_entries_on_recommender_processed"

  create_table "entries_tags", :id => false, :force => true do |t|
    t.integer "entry_id", :null => false
    t.integer "tag_id"
  end

  add_index "entries_tags", ["entry_id"], :name => "index_entries_tags_on_entry_id"
  add_index "entries_tags", ["tag_id"], :name => "index_entries_tags_on_tag_id"

  create_table "entries_users", :force => true do |t|
    t.integer  "entry_id",                           :null => false
    t.integer  "user_id",         :default => 0
    t.boolean  "clicked_through", :default => false
    t.datetime "created_at"
  end

  add_index "entries_users", ["entry_id", "user_id"], :name => "index_entries_users_entry_id_user_id"
  add_index "entries_users", ["entry_id"], :name => "index_entries_users_on_entry_id"
  add_index "entries_users", ["user_id"], :name => "index_entries_users_on_user_id"

  create_table "entry_images", :force => true do |t|
    t.integer "entry_id"
    t.string  "uri",      :limit => 2083
    t.string  "link",     :limit => 2083
    t.string  "alt"
    t.string  "title"
    t.integer "width"
    t.integer "height"
  end

  add_index "entry_images", ["entry_id"], :name => "index_entry_images_on_entry_id"

  create_table "feed_types", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "feeds", :force => true do |t|
    t.string   "uri",               :limit => 2083
    t.string   "display_uri",       :limit => 2083
    t.string   "title",             :limit => 1000
    t.string   "short_title",       :limit => 100
    t.text     "description"
    t.string   "tag_filter",        :limit => 1000
    t.text     "top_tags"
    t.integer  "priority",                          :default => 10
    t.integer  "status",                            :default => 1
    t.datetime "last_requested_at"
    t.datetime "last_harvested_at"
    t.string   "harvest_interval",  :limit => nil,  :default => "06:00:00"
    t.integer  "failed_requests",                   :default => 0
    t.text     "error_message"
    t.integer  "service_id",                        :default => 0,          :null => false
    t.string   "login"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_type_id"
    t.integer  "user_id"
  end

  add_index "feeds", ["feed_type_id"], :name => "index_feeds_on_feed_type_id"
  add_index "feeds", ["service_id"], :name => "index_feeds_on_service_id"
  add_index "feeds", ["uri"], :name => "index_feeds_on_uri", :unique => true
  add_index "feeds", ["user_id"], :name => "index_feeds_on_user_id"

  create_table "micro_concerts", :force => true do |t|
    t.integer "micro_event_id"
    t.string  "performer"
    t.string  "ticket_url",     :limit => 2083
  end

  add_index "micro_concerts", ["micro_event_id"], :name => "index_micro_concerts_on_micro_event_id"

  create_table "micro_conferences", :force => true do |t|
    t.integer  "micro_event_id"
    t.string   "theme"
    t.datetime "register_by"
    t.datetime "submit_by"
  end

  add_index "micro_conferences", ["micro_event_id"], :name => "index_micro_conferences_on_micro_event_id"

  create_table "micro_event_links", :force => true do |t|
    t.integer "micro_event_id"
    t.string  "uri"
    t.string  "title"
  end

  add_index "micro_event_links", ["micro_event_id"], :name => "index_micro_event_links_on_micro_event_id"

  create_table "micro_event_people", :force => true do |t|
    t.integer "micro_event_id"
    t.string  "name"
    t.string  "role"
    t.string  "email"
    t.string  "link",           :limit => 2083
    t.string  "phone"
  end

  add_index "micro_event_people", ["micro_event_id"], :name => "index_micro_event_people_on_micro_event_id"

  create_table "micro_events", :force => true do |t|
    t.integer  "entry_id",    :null => false
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "price"
    t.text     "image"
    t.text     "address"
    t.text     "subaddress"
    t.string   "city"
    t.string   "state"
    t.string   "postcode"
    t.string   "country"
    t.datetime "begins",      :null => false
    t.datetime "ends"
    t.text     "tags"
    t.string   "duration"
    t.text     "location"
  end

  add_index "micro_events", ["entry_id"], :name => "index_micro_events_on_entry_id"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.binary  "server_url"
    t.string  "handle"
    t.binary  "secret"
    t.integer "issued"
    t.integer "lifetime"
    t.string  "assoc_type"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.string  "nonce"
    t.integer "created"
  end

  create_table "open_id_authentication_settings", :force => true do |t|
    t.string "setting"
    t.binary "value"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :default => "", :null => false
  end

  create_table "services", :force => true do |t|
    t.string  "uri",               :limit => 2083, :default => "",    :null => false
    t.string  "title",             :limit => 1000, :default => "",    :null => false
    t.string  "api_uri",           :limit => 2083, :default => "",    :null => false
    t.string  "uri_template",      :limit => 2083, :default => "",    :null => false
    t.string  "icon",              :limit => 2083
    t.integer "sequence"
    t.boolean "requires_password",                 :default => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  add_index "tags", ["name"], :name => "index_tags_on_lower_name"
  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 80,   :default => "",                 :null => false
    t.string   "crypted_password",          :limit => 40,   :default => "",                 :null => false
    t.string   "email",                     :limit => 60,   :default => "",                 :null => false
    t.string   "firstname",                 :limit => 40
    t.string   "lastname",                  :limit => 40
    t.string   "salt",                      :limit => 40,   :default => "",                 :null => false
    t.integer  "verified",                                  :default => 0
    t.string   "role",                      :limit => 40
    t.string   "security_token",            :limit => 40
    t.datetime "token_expiry"
    t.string   "login_token",               :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "logged_in_at"
    t.integer  "deleted",                                   :default => 0
    t.datetime "delete_after"
    t.string   "image_path",                :limit => 40,   :default => "default_user_img"
    t.string   "blurb",                     :limit => 2000
    t.string   "location",                  :limit => 100
    t.string   "website",                   :limit => 2083
    t.datetime "activated_at"
    t.string   "identity_url"
    t.string   "activation_code",           :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "watched_pages", :force => true do |t|
    t.integer  "entry_id"
    t.datetime "harvested_at"
    t.boolean  "has_microformats", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watched_pages", ["entry_id"], :name => "index_watched_pages_on_entry_id"

end
