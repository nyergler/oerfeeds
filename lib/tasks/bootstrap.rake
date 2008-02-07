namespace :db do
  desc "Loads a schema.rb file into the database and then loads the initial database fixtures."
  task :bootstrap_oerc => ['db:bootstrap_oerc:load']
  
  namespace :bootstrap_oerc do
    desc "Load OERC OAI feeds. "
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)

      # create the OERC aggregation
      current_id = (ActiveRecord::Migration.execute "SELECT nextval('feeds_id_seq')").result.to_s
      ActiveRecord::Migration.execute "INSERT INTO aggregations (name, title, description, user_id, created_at, updated_at) VALUES ('oerc', 'OER Commons', 'OER Commons Feeds.', 0, now(), now())"
      Fixtures.new(Feed.connection,"feeds",Feed,File.join(RAILS_ROOT, 'db', 'bootstrap',"oerc_feeds")).insert_fixtures
      ActiveRecord::Migration.execute "INSERT INTO aggregation_feeds (aggregation_id, feed_id) SELECT aggregations.id AS aggregation_id, feeds.id AS feed_id FROM (SELECT id FROM aggregations WHERE aggregations.name='oerc') AS aggregations CROSS JOIN feeds WHERE feeds.id > #{current_id}"
    end
  end
end

namespace :db do
  desc "Loads a schema.rb file into the database and then loads the initial database fixtures."
  task :bootstrap_nsdl => ['db:bootstrap_nsdl:load']
  
  namespace :bootstrap_nsdl do
    desc "Load NSDL OAI feeds. "
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)

      # create the default aggregation
      ActiveRecord::Migration.execute "INSERT INTO aggregations (name, title, description, user_id, created_at, updated_at) VALUES ('default', 'Default Aggregation', 'All feeds except NSDL or OCW.', 0, now(), now())"
      ActiveRecord::Migration.execute "INSERT INTO aggregation_feeds (aggregation_id, feed_id, created_at, updated_at) SELECT aggregations.id AS aggregation_id, feeds.id AS feed_id, now(), now() FROM (SELECT id FROM aggregations WHERE aggregations.name='default') AS aggregations CROSS JOIN feeds"

      # create the NSDL aggregation
      current_id = (ActiveRecord::Migration.execute "SELECT nextval('feeds_id_seq')").result.to_s
      ActiveRecord::Migration.execute "INSERT INTO aggregations (name, title, description, user_id, created_at, updated_at) VALUES ('nsdl', 'National Science Digital Library', 'OIA feeds from selected NSDL collections.', 0, now(), now())"
      Fixtures.new(Feed.connection,"feeds",Feed,File.join(RAILS_ROOT, 'db', 'bootstrap',"nsdl_feeds")).insert_fixtures
      ActiveRecord::Migration.execute "INSERT INTO aggregation_feeds (aggregation_id, feed_id) SELECT aggregations.id AS aggregation_id, feeds.id AS feed_id, FROM (SELECT id FROM aggregations WHERE aggregations.name='nsdl') AS aggregations CROSS JOIN feeds WHERE feeds.id > " + current_id.to_s
    end
  end
end

namespace :db do
  desc "Loads a schema.rb file into the database and then loads the initial database fixtures."
  task :bootstrap_ocw => ['db:bootstrap_ocw:load']
  
  namespace :bootstrap_ocw do
    desc "Load OCW feeds. "
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)

      # create the OCW aggregation
      current_id = (ActiveRecord::Migration.execute "SELECT nextval('feeds_id_seq')").result.to_s
      ActiveRecord::Migration.execute "INSERT INTO aggregations (name, title, description, user_id, created_at, updated_at) VALUES ('ocw', 'OpenCourseWares', 'OpenCourseWare Feeds.', 0, now(), now())"
      Fixtures.new(Feed.connection,"feeds",Feed,File.join(RAILS_ROOT, 'db', 'bootstrap',"ocw_feeds")).insert_fixtures
      ActiveRecord::Migration.execute "INSERT INTO aggregation_feeds (aggregation_id, feed_id) SELECT aggregations.id AS aggregation_id, feeds.id AS feed_id FROM (SELECT id FROM aggregations WHERE aggregations.name='ocw') AS aggregations CROSS JOIN feeds WHERE feeds.id > #{current_id}"
    end
  end
end
