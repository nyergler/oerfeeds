class DefaultController < ApplicationController

    def index
        @feeds = Feed.find(:all, :limit => 40)
        respond_to do |format|
            format.html # index.html.erb
        end
    end

end