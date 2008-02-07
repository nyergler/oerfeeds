class FeedsController < ApplicationController
    
    require "cgi"
  
    before_filter :login_required, :except => [:show]
    before_filter :authorization_required, :only => [:destroy, :edit, :update]
   
    layout "default"

    # GET /feeds
    # GET /feeds.xml
    def index
        if !@aggregation.nil?
            @page_title = @aggregation.title
            @feeds = @aggregation.feeds
        else
            @page_title = 'Feeds'
            @feeds = Feed.find(:all, :limit => 100) if @feeds.nil?
        end
    end

    def show_feeds
        @feeds = Feed.find(:all, :limit => 20) if @feeds.nil?
        @tags = Feed.get_feed_tags()
    end
    
    def filter
        @feeds = Feed.get_feeds_tagged("alpha", params[:tag], {:limit => 100})
        render_index
    end

    def search
        @feeds = Feed.search(params[:search_terms], {:limit => 100})
        render_index
    end

    # GET /feeds/1
    # GET /feeds/1.xml
    def show
        
        @feed = Feed.find(params[:id])
        @entries = Entry.get_entries_for_feed(@feed.id, {:limit => 50})
        @page_title = @feed.title
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @feed }
        end
    end

    # GET /feeds/new
    # GET /feeds/new.xml
    def new
        @feed = Feed.new
        @aggregation = Aggregation.find(params[:aggregation_id]) 
        if @aggregation.nil?
        Aggregations.new    
        end
        
        @available_services = Service.available_services
        @page_title = 'Add to ' + @aggregation.title
        
        respond_to do |format|
            format.html
            format.xml  { render :xml => @feed }
        end
    end

    def new_too
        @aggregation = Aggregation.find(params[:aggregation_id])
        @service = Service.find(params[:service_id])
        @feed = Feed.new
        
        respond_to do |format|
            format.html
            format.xml  { render :xml => @service }
        end
        
    end
    
    # GET /feeds/1/edit
    def edit
        @feed = Feed.find(params[:id])
    end

    # POST /feeds
    # POST /feeds.xml
    def create
        @aggregation = Aggregation.find(params[:aggregation_id])
        @available_services = Service.available_services
        @page_title = 'Add to ' + @aggregation.title
        @service = Service.find(params[:service_id] || Aggregator::ServiceConstants::RSS)
        
        local_params = params
        local_params = params[:feed] if params[:feed]
        @feed = Feed.new
        @feed.create_feeds(current_user, local_params, @service, @aggregation)
        
        respond_to do |format|
            format.html { render :action => "new_too" }
            format.xml  { render :xml => @feed.added_feeds }
        end
    end

    # PUT /feeds/1
    # PUT /feeds/1.xml
    def update
        @feed = Feed.find(params[:id])

        respond_to do |format|
            if @feed.update_attributes(params[:feed])
                flash[:notice] = 'Feed was successfully updated.'
                format.html { redirect_to(@feed) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @feed.errors }
            end
        end
    end

    # DELETE /feeds/1
    # DELETE /feeds/1.xml
    def destroy
        @feed = Feed.find(params[:id])
        @feed.destroy

        respond_to do |format|
            format.html { redirect_to(feeds_url) }
            format.xml  { head :ok }
        end
    end

    def upload_opml_file

    end

    protected
        
    def get_aggregation
        @aggregation = params[:aggregation_id] ? Aggregation.find(params[:aggregation_id]) : nil
    end

    def render_index
        @feeds = @feeds.delete_if{|f| @aggregation.feeds.include?(f)} # remove items that are already part of the aggregation
        @tags = Feed.get_feed_tags
        respond_to do |format|
            format.html { render(:template => 'feeds/index') }
            format.xml  { render :xml => @feeds }
        end
    end

    def authorization_required

    end

end
