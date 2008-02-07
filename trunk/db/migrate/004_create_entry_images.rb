class CreateEntryImages < ActiveRecord::Migration
  def self.up
    create_table :entry_images do |t|
      t.integer :entry_id
      t.string :uri, :limit => 2083
      t.string :link, :limit => 2083
      t.string :alt
      t.string :title
      t.integer :width
      t.integer :height
    end
    add_index :entry_images, :entry_id
  end

  def self.down
    remove_index :entry_images, :entry_id
    drop_table :entry_images
  end
end
