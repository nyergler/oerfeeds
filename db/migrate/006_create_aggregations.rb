class CreateAggregations < ActiveRecord::Migration
  def self.up
    create_table :aggregations do |t|
      t.string :name
      t.string :title
      t.text :description
      t.text :top_tags
      t.integer :user_id
      t.timestamps 
    end
    
    add_index :aggregations, :user_id

    create_table :aggregation_feeds do |t|
      t.column :aggregation_id, :integer
      t.column :feed_id, :integer
    end
    
    add_index :aggregation_feeds, :feed_id
    add_index :aggregation_feeds, :aggregation_id
    
    create_table :aggregation_top_tags do |t|
      t.column :aggregation_id, :integer, :default => 0
      t.column :tag_id, :integer
      t.column :hits, :integer
    end
    
    add_index :aggregation_top_tags, :aggregation_id
    add_index :aggregation_top_tags, :tag_id
  end
  
  def self.down
    remove_index :aggregation_top_tags, :tag_id
    remove_index :aggregation_top_tags, :aggregation_id
    
    drop_table :aggregation_top_tags
    
    remove_index :aggregation_feeds, :feed_id
    remove_index :aggregation_feeds, :aggregation_id
    
    drop_table :aggregation_feeds
    
    remove_index :aggregations, :user_id

    drop_table :aggregations
  end
end
