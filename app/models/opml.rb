class Opml

    attr_accessor :problem_feeds
    attr_accessor :added_feeds
    attr_accessor :already_feeds

    def initialize
        self.problem_feeds = []
        self.added_feeds = []
        self.already_feeds = []
    end

    # gets feeds from xml document and creates them
    def setup_feeds(opml, aggregation)
        @service = Service.find(Aggregator::ServiceConstants::RSS)
        opml_items = parse_opml(opml.elements['opml/body'])
        opml_items.each do |key, value|
            added = true
            # uri = key, title = value[1]
            if !key.nil?
                @feed = Feed.find_or_create(key, value[1], '', '', @service.id)
                @feed.user = nil
                @feed.title = @feed.uri if @feed.title.nil?

                if aggregation.feeds.include?(@feed)
                    self.already_feeds.push(@feed.title)
                else
                    if @feed.save # have to save here so that feed has an id.  Without id can't associate with aggregation
                        @feed.aggregations << aggregation
                        if !@feed.save # add on the aggregation
                            added = false
                        end
                    else
                        added = false
                    end

                    if !added
                        self.problem_feeds.push(@feed.title)
                    else
                        self.added_feeds.push(@feed.title)
                    end
                end
            end
        end
    end


    def found_feeds?
        if @problem_feeds.empty? and @added_feeds.empty? and @already_feeds.empty?
            false
        else
            true
        end
    end

    private
    #############################################################
    # takes an REXML::Element that has OPML outline nodes as children, parses its
    # subtree recursively and returns a hash: { feed_url => [parent_name_1,
    # parent_name_2, ...] }
    def parse_opml(opml_node, parent_names=[])
        feeds = {}

        return feeds if opml_node.nil?

        opml_node.elements.each('outline') do |el|
            if (el.elements.size != 0)
                feeds.merge!(parse_opml(el, parent_names + [el.attributes['text']]))
            end

            if (el.attributes['xmlUrl'])
                feeds[el.attributes['xmlUrl']] = [parent_names, el.attributes['title']]
            end

        end

        return feeds
    end

    def base_part_of(file_name)
        File.basename(file_name).gsub(/[^\w._-]/, '')
    end

    #    def sanitize_filename(value)
    #        # get only the filename, not the whole path
    #        just_filename = value.gsub(/^.*(\\|\/)/, '')
    #        # NOTE: File.basename doesn't work right with Windows paths on Unix
    #        # INCORRECT: just_filename = File.basename(value.gsub('\\\\', '/'))
    #
    #        # Finally, replace all non alphanumeric, underscore or periods with underscore
    #        @filename = just_filename.gsub(/[^\w\.\-]/,'_')
    #    end

end
