class Feed < ActiveRecord::Base
    include Aggregator::FeedModel

    belongs_to :user, :through => :feeds_users
    
    def after_initialize
        self.problem_feeds = []
        self.added_feeds = []
        self.already_feeds = []
        self.tags = ''
        self.technorati = 1
    	self.google_news = 1
    	self.google_blog = 1
    	self.delicious = 1
    	self.flickr = 1
    end
        
    ##########################################################
    # search feeds
    def self.search(terms, options = {})
        sql = "SELECT feeds.* FROM feeds "
        sql << "WHERE "
        sql << make_and_sql_where("feeds.title", terms, "%")
        sql << " OR "
        sql << make_and_sql_where("feeds.uri", terms, "%")
        sql << " "
        sql << " UNION "
        sql << " SELECT feeds.* FROM feeds "
        sql << " INNER JOIN feeds_users ON feeds_users.feed_id = feeds.id "
        sql << " INNER JOIN feeds_users_tags ON feeds_users_tags.feeds_user_id = feeds_users.id "
        sql << " INNER JOIN tags ON tags.id = feeds_users_tags.tag_id "
        sql << " WHERE "
        sql << terms.collect {|tag| sanitize_sql( ["tags.name LIKE ?", tag])}.join(" OR ")
        add_limit!(sql, options)
        find_by_sql(sql)
    end

    ##########################################################
    # Lists all feeds and flags which ones a user is subscribed to
    #
    # Called by:
    #   feed_controller.index
    #
    def self.get_feeds(user_id, tab = "alpha", options = {:limit => 20})
        case tab
        when "new"
            order = "feeds.created_at DESC"
        when "alpha"
            order = "lower(feeds.title) ASC"
        else # popular
            order = "subscribers DESC, lower(feeds.title) ASC"
        end

        sql = "SELECT feeds.id, feeds.title, feeds.uri, feeds.display_uri, feeds.description, oage(feeds.created_at) AS age, "
        sql << "COUNT(feeds_users.user_id) as subscribers, BOOL_OR(feeds_users.user_id = ?) AS subscribed "
        sql << "FROM feeds "
        sql << "LEFT JOIN feeds_users ON feeds_users.feed_id = feeds.id "
        sql << "GROUP BY feeds.id, feeds.title, feeds.description, feeds.created_at, feeds.uri, feeds.display_uri "
        sql << "ORDER BY " + order
        add_limit!(sql, options)
        find_by_sql([sql, user_id])
    end

    ##########################################################
    # gets a feed
    #
    # Called by:
    #   feed_controller.show
    #
    def self.get_feed_info(feed_id, user_id)
        sql = "SELECT feeds.id, feeds.title, feeds.description, feeds.service_id, oage(feeds.created_at) AS age, "
        sql << "COUNT(feeds_users.user_id) as subscribers, BOOL_OR(feeds_users.user_id = ?) AS subscribed "
        sql << "FROM feeds "
        sql << "LEFT JOIN feeds_users ON feeds_users.feed_id = feeds.id "
        sql << "WHERE feeds.id = ? "
        sql << "GROUP BY feeds.id, feeds.title, feeds.description, feeds.service_id, feeds.created_at "
        sql << "LIMIT 1"
        find_by_sql([sql, user_id, feed_id])[0]
    end

    ##########################################################
    # gets a feed
    #
    # Called by:
    #   user_controller.get_feed_info
    #
    def self.get_feed_info_by_uri(feed_url, user_id)
        sql = "SELECT feeds.id, feeds.title, feeds.description, feeds.service_id, oage(feeds.created_at) AS age, "
        sql << "COUNT(feeds_users.user_id) as subscribers, BOOL_OR(feeds_users.user_id = ?) AS subscribed "
        sql << "FROM feeds "
        sql << "LEFT JOIN feeds_users ON feeds_users.feed_id = feeds.id "
        sql << "WHERE feeds.uri = ? "
        sql << "GROUP BY feeds.id, feeds.title, feeds.description, feeds.service_id, feeds.created_at "
        sql << "LIMIT 1"
        find_by_sql([sql, user_id, feed_url])[0]
    end

    #############################################################
    # Gets feeds that contain shared entries tagged specified way
    #
    # Called by:
    #   feed_controller.feeds_tagged
    #
    def self.get_feeds_tagged(tab = "new", filter_tags = nil, options = {:limit => 20})
        case tab
        when "new"
            order = "feeds.created_at DESC"
        when "alpha"
            order = "lower(feeds.title) ASC"
        else # popular
            order = "subscribers DESC, lower(feeds.title) ASC"
        end

        sql = "SELECT feeds.id, feeds.title, feeds.description, feeds.display_uri, feeds.uri "
        sql << "FROM feeds "
        sql << "INNER JOIN feeds_users ON feeds.id = feeds_users.feed_id "
        sql << "INNER JOIN feeds_users_tags ON feeds_users.id = feeds_users_tags.feeds_user_id "
        sql << "INNER JOIN tags ON feeds_users_tags.tag_id = tags.id "
        sql << "WHERE " + make_and_sql_where("tags.name", filter_tags) if filter_tags
        sql << "GROUP BY feeds.id, feeds.title, feeds.description, feeds.display_uri, feeds.uri "
        sql << "ORDER BY " + order
        add_limit!(sql,options)

        find_by_sql(sql)
    end

    ##########################################################
    # Finds tags applied to entries in a feed, possibly narrowed
    # to the entries that have been tagged with specified tags
    #
    # Called by:
    #   feed_controller.show
    #
    def self.get_feed_tags(options = {})
        sql = "SELECT name, count FROM ("
        sql << "SELECT tags.name, COUNT(tags.id) as count "
        sql << "FROM tags "
        sql << "INNER JOIN feeds_users_tags ON tags.id = feeds_users_tags.tag_id "
        sql << "GROUP BY tags.name "
        add_limit!(sql,options)
        sql << ") AS t ORDER BY LOWER(t.name)"
        Tag.find_by_sql(sql)
    end

    ##########################################################
    # Finds tags applied to entries in a feed, possibly narrowed
    # to the entries that have been tagged with specified tags
    #
    # Called by:
    #   feed_controller.show
    #
    def get_filter_tags(tags, options = {})

        sql = "SELECT tags.name, COUNT(tags.id) as count "
        sql << "FROM entries "
        sql << "INNER JOIN entries_tags ON entries_tags.entry_id = entries.id "
        sql << "INNER JOIN tags ON entries_tags.tag_id = tags.id "
        sql << "WHERE entries.feed_id = ? "
        if tags and tags.length > 0
            sql << "AND entries.id IN "
            sql << "("
            #The following code finds entries that share the same tags
            sql << "	SELECT et1.entry_id "
            sql << "	FROM entries_tags AS et1 "
            sql << "	INNER JOIN tags t1 ON t1.id = et1.tag_id "

            counter = 1
            tags.each do |tag|
                counter = counter + 1
                sql << "INNER JOIN entries_tags AS et" + counter.to_s + " ON et" + counter.to_s + ".entry_id = et1.entry_id "
                sql << "INNER JOIN tags t" + counter.to_s + " ON t" + counter.to_s + ".id = et" + counter.to_s + ".tag_id "
            end

            sql << "WHERE "

            connector = ""
            counter = 1
            tags.each do |tag|
                counter = counter + 1
                sql << connector + " t" + counter.to_s + ".name = '" + tag + "' "
                connector = " AND "
            end

            sql << ") "
        end
        sql << "GROUP BY tags.id, tags.name "
        sql << "ORDER BY count DESC "

        add_limit!(sql, options)

        result = Tag.find_by_sql([sql, self.id])
        count = result.inject({}) { |hsh, row| hsh[row['name']] = row['count'].to_i; hsh } unless options[:raw]
        count || result
    end

    ##########################################################
    # Get all tags applied to entries published to a feed
    #
    # Called by:
    #   feed/index.rhtml
    #
    def get_tags(options = {})
        sql = "SELECT t.id, t.name, COUNT(t.id) AS count "
        sql << "FROM tags t "
        sql << "INNER JOIN entries_tags ON t.id = entries_tags.tag_id "
        sql << "INNER JOIN entries ON entries_tags.entry_id = entries.id "
        sql << "WHERE entries.feed_id = ? "
        sql << "GROUP BY t.id, t.name "
        sql << "ORDER BY count DESC"
        add_limit!(sql, options)

        result = Tag.find_by_sql([sql,self.id])
        count = result.inject({}) { |hsh, row| hsh[row['name']] = row['count'].to_i; hsh } unless options[:raw]
        count || result
    end

    ##########################################################
    # Finds entries from feeds that are tagged with the given tags
    #
    # Called by:
    #   feed_controller.entries_tagged
    #
    def get_entries_tagged(tags, options = {})
        sql = "SELECT DISTINCT ON(entries.published_at, entries.id) entries.*, oage(entries.published_at) as age, feeds.service_id "
        sql << "FROM entries "
        sql << "INNER JOIN entries_tags ON entries.id = entries_tags.entry_id "
        sql << "INNER JOIN tags ON entries_tags.tag_id = tags.id "
        sql << "INNER JOIN feeds ON entries.feed_id = feeds.id "
        sql << "WHERE entries.feed_id = ? AND "
        sql << make_and_sql_where("tags.name", tags)
        sql << "ORDER BY entries.published_at DESC, entries.id "
        add_limit!(sql, options)
        Entry.find_by_sql([sql, self.id])
    end

    ##########################################################
    # this method will examine the service and parameters then create
    # and add the appropriate feeds
    def create_feeds(user, local_params, service, aggregation)

        uri_templates = Array.new
             
        if service.id == Aggregator::ServiceConstants::TAG
        
            self.technorati = local_params[:technorati]
            self.google_news = local_params[:google_news]
            self.google_blog = local_params[:google_blog]
            self.delicious = local_params[:delicious]
            self.flickr = local_params[:flickr]
        
        #http://wordpress.com/tag/railsconf07/feed/
        
            uri_templates.push(:title => 'Technorati', :uri => Aggregator::FeedTagSearchTemplates::TECHNORATI) if self.technorati == '1'
            uri_templates.push(:title => 'Google News', :uri => Aggregator::FeedTagSearchTemplates::GOOGLENEWS) if self.google_news == '1'
            uri_templates.push(:title => 'Google Blog Search', :uri => Aggregator::FeedTagSearchTemplates::GOOGLEBLOG) if self.google_blog == '1'
            uri_templates.push(:title => 'Delicious', :uri => Aggregator::FeedTagSearchTemplates::DELICIOUS) if self.delicious == '1'
            uri_templates.push(:title => 'Flickr', :uri => Aggregator::FeedTagSearchTemplates::FLICKR) if self.flickr == '1'
        elsif service.id == Aggregator::ServiceConstants::FLICKR
            uri_templates.push(:title => 'Flickr', :uri => Aggregator::FeedTagSearchTemplates::FLICKR)
        elsif service.id == Aggregator::ServiceConstants::WORDPRESS
            uri_templates.push(:title => 'Wordpress', :uri => Aggregator::FeedTagSearchTemplates::WORDPRESS)
        elsif service.id == Service::CITEULIKE
            uri_templates.push(:title => 'CiteULike', :uri => Aggregator::FeedTagSearchTemplates::CITEULIKE)
        elsif service.id == Aggregator::ServiceConstants::GOOGLENEWS
            uri_templates.push(:title => 'Google News', :uri => Aggregator::FeedTagSearchTemplates::GOOGLENEWS)
        elsif service.id == Aggregator::ServiceConstants::TECHNORATI
            uri_templates.push(:title => 'Technorati', :uri => Aggregator::FeedTagSearchTemplates::TECHNORATI)
        elsif service.id == Aggregator::ServiceConstants::GOOGLEBLOG
            uri_templates.push(:title => 'Google Blog Search', :uri => Aggregator::FeedTagSearchTemplates::GOOGLEBLOG)
        elsif service.id == Aggregator::ServiceConstants::DELICIOUS
            uri_templates.push(:title => 'Delicious', :uri => Aggregator::FeedTagSearchTemplates::DELICIOUS)
        end
        
        self.tags = local_params[:tags]
        tags = local_params[:tags].nil? ? [] : local_params[:tags].split(' ')
        self.login = login = local_params[:login] || ''
        self.password = password = local_params[:password] || ''
        self.uri = uri = local_params[:uri] || ''
        
        if service.id != Aggregator::ServiceConstants::RSS
        
            if tags.length > 0
                uri_templates.each do |uri_template|
                    create_tag_feed(uri_template, tags, service, aggregation)
                end
            end
        
            if login.length > 0
                create_username_password_feed(user, login, password, service, aggregation)
            end

        end        
        
        if uri.length > 0
            create_uri_feed(uri, aggregation, service)
        end
        
    end

protected    
    ##########################################################
    # creates a feed from a uri
    def create_uri_feed(uri, aggregation, service)
        feed = Feed.find_or_create(uri, uri, '', '', service.id)
        feed.user = nil
        add_feed_to_aggregation(aggregation, feed)
    end
    
    ##########################################################
    # creates a feed for a service with a username and optional password
    def create_username_password_feed(user, login, password, service, aggregation)
        uri = service.uri_template.sub("{username}", login)
        title = login + "'s " + service.title
        feed = Feed.find_or_create(uri, title, login, password, service.id)
        feed.user = user
        add_feed_to_aggregation(aggregation, feed)
    end
        
end
