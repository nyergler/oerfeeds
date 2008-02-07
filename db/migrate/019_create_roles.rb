class CreateRoles < ActiveRecord::Migration

    def self.up
        create_table :roles do |t|
            t.column :name, :string, :default => "", :null => false
        end
        
        # default roles
        execute "INSERT INTO roles (id, name) VALUES (1, 'organizer')"
        execute "INSERT INTO roles (id, name) VALUES (2, 'speaker')"
        execute "INSERT INTO roles (id, name) VALUES (3, 'attendee')"
        
    end

    def self.down
        drop_table :roles
    end

end
