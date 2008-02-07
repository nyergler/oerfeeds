class FeedsController < ApplicationController
    
    require "cgi"
  
    before_filter :login_required, :except => [:index, :search, :show]
    before_filter :authorization_required, :only => [:destroy, :edit, :update]
    before_filter :setup_user, :except => [:index, :search, :show]
    
    layout "default"

    # GET /feeds
    # GET /feeds.xml
    def index
        @page_title = 'Feeds'
        @feeds = Feed.find(:all, :limit => 100) if @feeds.nil?
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
        @page_title = 'Add Feed'
        
        respond_to do |format|
            format.html
            format.xml  { render :xml => @feed }
        end
    end
    
    # GET /feeds/1/edit
    def edit
        @feed = Feed.find(params[:id])
    end

    # POST /feeds
    # POST /feeds.xml
    def create
        @page_title = 'Added Feed'
        
        @feed = Feed.new
        @feed.title = params[:title]
        @feed.uri = params[:uri]
        if @feed.save
            flash[:notice] = 'Feed was successfully added.'
            @user.feeds << @feed
        end
        
        respond_to do |format|
            format.html
            format.xml  { render :xml => @feed }
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


    protected
  
    def render_index
        respond_to do |format|
            format.html { render(:template => 'feeds/index') }
            format.xml  { render :xml => @feeds }
            format.opml  { render(:template => 'feeds/index.opml.builder', :xml => @feeds) }
        end
    end

    def authorization_required

    end

    def setup_user
        @user = User.find(params[:user_id]) || current_user
    end
    
end
