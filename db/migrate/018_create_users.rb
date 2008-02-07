class CreateUsers < ActiveRecord::Migration
    def self.up
        create_table :users, :force => true do |t|
            t.string   "login",            :limit => 80,   :default => "",                 :null => false
            t.string   "crypted_password", :limit => 40,   :default => "",                 :null => false
            t.string   "email",            :limit => 60,   :default => "",                 :null => false
            t.string   "firstname",        :limit => 40
            t.string   "lastname",         :limit => 40
            t.string   "salt",             :limit => 40,   :default => "",                 :null => false
            t.integer  "verified",                         :default => 0
            t.string   "role",             :limit => 40
            t.string   "security_token",   :limit => 40
            t.datetime "token_expiry"
            t.string   "login_token",      :limit => 40
            t.datetime "created_at"
            t.datetime "updated_at"
            t.datetime "logged_in_at"
            t.integer  "deleted",                          :default => 0
            t.datetime "delete_after"
            t.string   "image_path",       :limit => 40,   :default => "default_user_img"
            t.string   "blurb",            :limit => 2000
            t.string   "location",         :limit => 100
            t.string   "website",          :limit => 2083
            t.datetime "activated_at"
            t.string   "identity_url"
            t.string   "activation_code",  :limit => 40
            t.string   "remember_token"
            t.datetime "remember_token_expires_at"
        end
    end

    def self.down
        drop_table :users
    end
end