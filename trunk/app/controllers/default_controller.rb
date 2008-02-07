class FeedsController < ApplicationController

    def index
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @users }
        end
    end

end