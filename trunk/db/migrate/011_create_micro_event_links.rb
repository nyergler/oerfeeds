class CreateMicroEventLinks < ActiveRecord::Migration
  def self.up
    create_table :micro_event_links do |t|
      t.integer :micro_event_id
      t.string :uri
      t.string :title
    end
    add_index :micro_event_links, :micro_event_id
  end

  def self.down
    remove_index :micro_event_links, :micro_event_id
    drop_table :micro_event_links
  end
end
