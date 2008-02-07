xml.instruct!

xml.opml("version" => "1.0") do
	xml.head do
	end
	xml.body do
		xml.outline 
	end
end


headers["Content-Type"] = "application/rss+xml"
xml.instruct!
	
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
    xml.channel do

    xml.title       "Blog posts for " + @event.title
    xml.link        url_for(request.env["REQUEST_URI"])
    xml.pubDate     CGI.rfc1123_date @entries.first.updated_at if @entries.any?
    xml.description "Blog posts for " + @event.title
	xml.generator '51weeks'

    @entries.each do |entry|
      xml.item do
        xml.title       entry.title
        xml.link        entry.permalink
        xml.description "type" => "html" do
           xml.text! entry.content || entry.description
        end
        xml.pubDate     CGI.rfc1123_date entry.created_at
        xml.guid        entry.permalink
        xml.author      "#{entry.author} (#{entry.author})"
      end
    end

  end
end
