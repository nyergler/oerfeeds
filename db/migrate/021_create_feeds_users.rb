class CreateFeedsUsers < ActiveRecord::Migration
    def self.up

        # track which entries users have viewed
        create_table :feeds_users, :force => true do |t|
            t.column :feed_id, :integer, :null => false
            t.column :user_id, :integer, :default => 0
            t.column :created_at, :datetime
        end

        add_index :feeds_users, :feed_id, :name => 'index_entries_users_on_feed_id' 
        add_index :feeds_users, :user_id, :name => 'index_entries_users_on_user_id' 

    end

    def self.down
        remove_index :feeds_users, :name => 'index_entries_users_on_feed_id'
        remove_index :feeds_users, :name => 'index_entries_users_on_user_id'
        drop_table :feeds_users
    end
    
end
