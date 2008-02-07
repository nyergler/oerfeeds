class CreateEntriesUsers < ActiveRecord::Migration
  def self.up

    # track which entries users have viewed
    create_table :entries_users, :force => true do |t|
        t.column :entry_id, :integer, :null => false
        t.column :user_id, :integer, :default => 0
        t.column :clicked_through, :boolean, :default => false
        t.column :created_at, :datetime
    end
    
    add_index :entries_users, :entry_id, :name => 'index_entries_users_on_entry_id' 
    add_index :entries_users, :user_id, :name => 'index_entries_users_on_user_id' 
    add_index :entries_users, [:entry_id, :user_id], :name => 'index_entries_users_entry_id_user_id'
  end

  def self.down
    remove_index :entries_users, :name => 'index_entries_users_on_entry_id'
    remove_index :entries_users, :name => 'index_entries_users_on_user_id'
    remove_index :entries_users, :name => 'index_entries_users_entry_id_user_id'
    drop_table :entries_users
  end
end
