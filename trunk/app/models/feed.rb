class Feed < ActiveRecord::Base
    
    has_one :feed_type
    
    belongs_to :user
    
    validates_presence_of   :title
    validates_presence_of   :uri
    		
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
        
end
