namespace :db do
  desc "Loads a schema.rb file into the database and then loads the initial database fixtures."
  task :bootstrap_feeds => ['db:bootstrap_feeds:load']
  
  namespace :bootstrap_feeds do
    desc "Load feeds. "
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)

      current_id = (ActiveRecord::Migration.execute "SELECT nextval('feeds_id_seq')").result.to_s
      Fixtures.new(Feed.connection,"feeds",Feed,File.join(RAILS_ROOT, 'db', 'bootstrap',"feeds")).insert_fixtures
    end
  end
end

