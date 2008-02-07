class CreateMicroEventPeople < ActiveRecord::Migration
  def self.up
    create_table :micro_event_people do |t|
      t.integer :micro_event_id
      t.string :name
      t.string :role
      t.string :email
      t.string :link, :limit => 2083
      t.string :phone
    end
    add_index :micro_event_people, :micro_event_id
  end

  def self.down
    remove_index :micro_event_people, :micro_event_id
    drop_table :micro_event_people
  end
end
