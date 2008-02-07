class CreateFeedType < ActiveRecord::Migration
  
  def self.up
    create_table :feed_types do |t|
      t.column :name, :string, :null => false
    end
    add_column :feeds, "feed_type_id", :integer
    add_index :feeds, "feed_type_id"
    execute "INSERT INTO feed_types (id, name) VALUES (1, 'RSS')"
    execute "INSERT INTO feed_types (id, name) VALUES (2, 'OAI')"
    execute "INSERT INTO feed_types (id, name) VALUES (3, 'OPML')"
  end
  
  def self.down
    remove_index :feeds, "feed_type_id"
    remove_column :feeds, :feed_type_id
    drop_table :feed_types
  end
  
end
