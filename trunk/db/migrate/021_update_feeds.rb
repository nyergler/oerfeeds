class UpdateFeeds < ActiveRecord::Migration
  
  def self.up
    add_column :feeds, "user_id", :integer
    add_index :feeds, "user_id"
  end
  
  def self.down
    remove_index :feeds, "user_id"
    remove_column :feeds, :user_id
  end
  
end
