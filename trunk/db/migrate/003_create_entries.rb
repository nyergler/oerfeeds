class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :feed_id, :null => false
      t.string :permalink, :limit => 2083, :default => '', :null => false
      t.string :author, :limit => 2083
      t.text :title, :null => false
      t.text :description, :default => '', :null => false
      t.text :content, :default => '', :null => false
      t.boolean :unique_content, :default => false
      t.text :tag_list
      t.datetime :published_at, :null => false
      t.datetime :entry_updated_at
      t.datetime :harvested_at
      t.string :oai_identifier, :limit => 2083
    end

    add_index :entries, :feed_id
    add_index :entries, :permalink
    add_index :entries, :published_at, :name => "index_entries_on_published_at"
    add_index :entries, :oai_identifier

    execute "ALTER TABLE entries CLUSTER ON index_entries_on_published_at"
  end
  
  def self.down
    remove_index :entries, :feed_id
    remove_index :entries, :permalink
    remove_index :entries, :published_at
    remove_index :entries, :oai_identifier
    drop_table :entries
  end
end
