class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :uri, :limit => 2083, :default => '', :null => false
      t.string :title, :limit => 1000, :default => '', :null => false
      t.string :api_uri, :limit => 2083, :default => '', :null => false
      t.string :uri_template, :limit => 2083, :default => '', :null => false
      t.string :icon, :limit => 2083
      t.integer :sequence
      t.boolean :requires_password, :default => false
    end
    
    # default services
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (0, 'rss', '', '', '', 'rss-atom.gif', 1)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (1, 'del.icio.us', 'http://del.icio.us/', 'https://api.del.icio.us/v1/', '', 'delicious.gif', 7)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (2, 'Digg', 'http://www.digg.com', '', 'http://digg.com/rss/{username}/index2.xml', 'digg.gif', 8)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (3, '43 Places', 'http://www.43places.com', '', 'http://www.43places.com/rss/uber/author?username={username}', '43places.gif', 13)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (4, 'All Consuming', 'http://allconsuming.net/', '', 'http://allconsuming.net/person/{username}/rss', 'allconsuming.gif', 15)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (5, 'Clipmarks', 'http://www.clipmarks.com', '', 'http://rss.clipmarks.com/clipper/{username}/', 'clipmarks.gif', 16)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (6, 'Flickr', 'http://www.flickr.com', '', 'http://api.flickr.com/services/feeds/activity.gne?id={username}', 'flickr.gif', 9)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (7, 'Last.fm', 'http://www.last.fm', '', 'http://ws.audioscrobbler.com/1.0/user/{username}/recenttracks.rss', 'lastfm.gif', 17)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (8, 'LiveJournal', 'http://www.livejournal.com', '', 'http://{username}.livejournal.com', 'livejournal.gif', 18)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (9, 'Simpy', 'http://www.simpy.com', '', 'http://www.simpy.com/rss/user/{username}/links/', 'simpy.gif', 19)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (10, 'Wordpress.com', 'http://www.wordpress.com/', '', 'http://{username}.wordpress.com/', 'wordpress.gif', 11)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (11, 'Xanga', 'http://www.xanga.com', '', 'http://www.xanga.com/{username}/rss', 'xanga.gif', 12)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (12, '43 Things', 'http://www.43things.com', '', '', '43things.gif', 14)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (13, 'OAI', '', '', '', 'oai.gif', 23)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (14, 'You Tube', 'http://www.youtube.com', '', 'feed://www.youtube.com/rss/user/{username}/videos.rss', 'youtube.gif', 10)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (15, 'cite u like', 'http://www.citeulike.org/', '', 'http://www.citeulike.org/rss/user/{username}', 'citeulike.gif', 20)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (16, 'Google News', '', '', '', 'googlenews.gif', 4)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (17, 'OPML', '', '', '', 'opml.gif', 2)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (18, 'Tag', '', '', '', 'tag.gif', 3)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (19, 'Twitter', 'http://www.twitter.com', '', '', 'twitter.gif', 21)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (20, 'Odeo Podcasts', 'http://www.odeo.com', '', '', 'odeo.gif', 22)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (21, 'Technorati', 'http://www.technorati.com/', '', 'http://feeds.technorati.com/faves/{username}?format=rss', 'technorati.gif', 6)"
    execute "INSERT INTO services (id, title, uri, api_uri, uri_template, icon, sequence) VALUES (22, 'Google Blog Search', 'http://blogsearch.google.com/', '', '', 'googleblogs.gif', 5)"
  end
  
  def self.down
    drop_table :services
  end
end
