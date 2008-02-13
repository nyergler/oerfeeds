headers["Content-Type"] = "text/x-opml"
xml.instruct!

xml.opml("version" => "2.0") do
	xml.head do
		 xml.title "oerfeeds.info"
		 xml.dateModified ""
		 xml.ownerName "oerfeeds.info"
		 xml.ownerId "http://oerfeeds.info"
		 xml.ownerEmail "webmaster@oerfeeds.info"
		 xml.docs "http://www.opml.org/spec2"
	end

	xml.body do
		 @feeds.each do |feed|
		 xml.outline( :text => feed.title,
		 	      :type => "include",
			      :url => feed.uri
			      ) if feed.type == "opml"

		 xml.outline( :text => feed.title,
		 	      :type => feed.type,
			      :xmlUrl => feed.uri
			      ) unless feed.type == "opml"
			      
			      
		 end
	end	 
end
