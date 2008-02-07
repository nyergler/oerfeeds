class CreateMicroConferences < ActiveRecord::Migration
  def self.up
    create_table :micro_conferences do |t|
      t.integer :micro_event_id
      t.string :theme
      t.datetime :register_by
      t.datetime :submit_by
    end
    add_index :micro_conferences, :micro_event_id
  end

  def self.down
    remove_index :micro_conferences, :micro_event_id
    drop_table :micro_conferences
  end
end
