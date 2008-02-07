class CreateMicroEvents < ActiveRecord::Migration
  def self.up
    create_table :micro_events do |t|
      t.integer :entry_id, :null => false
      t.string :name, :null => false
      t.text :description
      t.string :price
      t.text :image
      t.text :address
      t.text :subaddress
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country
      t.datetime :begins, :null => false
      t.datetime :ends
      t.text :tags
      t.string :duration
      t.text :location
    end

    add_index :micro_events, :entry_id
  end

  def self.down
    remove_index :micro_events, :entry_id
    drop_table :micro_events
  end
end
