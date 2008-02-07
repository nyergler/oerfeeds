class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.string :uri, :limit => 2083
      t.string :display_uri, :limit => 2083
      t.string :title, :limit => 1000
      t.string :short_title, :limit => 100
      t.text :description
      t.string :tag_filter, :limit => 1000
      t.text :top_tags
      t.integer :priority, :default => 10
      t.integer :status, :default => 1
      t.datetime :last_requested_at
      t.datetime :last_harvested_at
      t.column :harvest_interval, :interval, :default => '6:00:00'
      t.integer :failed_requests, :default => 0
      t.text :error_message
      t.integer :service_id, :default => 0, :null => false
      t.string :login
      t.string :password
      t.timestamps 
    end

    add_index :feeds, :service_id
    add_index :feeds, :uri, :unique => true
  end
  
  def self.down
    remove_index :feeds, :service_id
    remove_index :feeds, :uri
    drop_table :feeds
  end
end
