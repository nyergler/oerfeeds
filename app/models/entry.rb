class Entry < ActiveRecord::Base
    include Aggregator::EntryModel
    
        
    def self.get_entries_for_feed(feed_id, options = {})
        sql = "SELECT entries.*, feeds.service_id, feeds.title AS feed_title, feeds.uri AS feed_uri FROM entries "
        sql << "INNER JOIN feeds on feeds.id = entries.feed_id "
        sql << "WHERE feeds.id = ? "
        sql << "ORDER By entries.published_at DESC "
        add_limit!(sql, options)
        Entry.find_by_sql([sql, feed_id])   
    end
    
    def self.get_entry(entry_id, options = {})
        sql = "SELECT entries.*, feeds.service_id, feeds.title AS feed_title, feeds.uri AS feed_uri FROM entries "
        sql << "INNER JOIN feeds on feeds.id = entries.feed_id "
        sql << "WHERE entries.id = ? "
        sql << "ORDER By entries.published_at DESC "
        add_limit!(sql, options)
        entries = Entry.find_by_sql([sql, entry_id])
        if entries and entries.length > 0
            entries[0]
        else
            nil
        end
    end
    
    
end
