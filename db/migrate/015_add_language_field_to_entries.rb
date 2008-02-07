class AddLanguageFieldToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, "language", :string
    add_index :entries, "language"
  end
  
  def self.down
    remove_index :entries, :language
    remove_column :entries, :language
  end
end
