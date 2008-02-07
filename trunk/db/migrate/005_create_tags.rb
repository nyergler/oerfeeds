class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.datetime :created_at 
    end
    
    add_index :tags, :name, :name => "index_tags_on_name"
    add_index :tags, :name, :case_sensitive => false, :name => "index_tags_on_lower_name"

    execute "ALTER TABLE tags CLUSTER ON index_tags_on_lower_name"
    
    create_table :entries_tags, :id => false do |t|
      t.column :entry_id, :integer, :null => false
      t.column :tag_id, :integer, :null => true
    end
    
    add_index :entries_tags, :entry_id
    add_index :entries_tags, :tag_id
    
  end
  
  def self.down
    remove_index :entries_tags, :entry_id
    remove_index :entries_tags, :tag_id
    
    drop_table :entries_tags
    
    remove_index :tags, :name => "index_tags_on_lower_name"
    remove_index :tags, :name => "index_tags_on_name"
    
    drop_table :tags
  end
end
