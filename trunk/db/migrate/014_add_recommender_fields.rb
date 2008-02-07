class AddRecommenderFields < ActiveRecord::Migration
  def self.up
    add_column :entries, "related_entries", :text
    add_column :entries, "recommender_processed", :boolean, :default => false
    add_index :entries, "recommender_processed"
  end
  
  def self.down
    remove_index :entries, :recommender_processed
    remove_column :entries, :recommender_processed
    remove_column :entries, :related_entries
  end
end
