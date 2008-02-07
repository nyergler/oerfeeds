class CreateWatchedPages < ActiveRecord::Migration
  def self.up
    create_table :watched_pages do |t|
      t.integer :entry_id
      t.datetime :harvested_at
      t.boolean :has_microformats, :default => false
      t.timestamps 
    end
    add_index :watched_pages, :entry_id
  end

  def self.down
    remove_index :watched_pages, :entry_id
    drop_table :watched_pages
  end
end
