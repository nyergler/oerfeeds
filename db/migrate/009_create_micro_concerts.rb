class CreateMicroConcerts < ActiveRecord::Migration
  def self.up
    create_table :micro_concerts do |t|
      t.integer :micro_event_id
      t.string :performer
      t.string :ticket_url, :limit => 2083
    end
    add_index :micro_concerts, :micro_event_id
  end

  def self.down
    remove_index :micro_concerts, :micro_event_id
    drop_table :micro_concerts
  end
end
