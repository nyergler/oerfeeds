class FeedsController < ApplicationController

    require "cgi"

    before_filter :login_required, :except => [:index, :search, :show]
    before_filter :authorization_required, :only => [:destroy, :edit, :update]
    before_filter :setup_user

    layout "default"

    # GET /feeds
    # GET /feeds.xml
    def index
        @page_title = 'Feeds'
        if !@user.nil?
            @feeds = @user.feeds
        else
            @feeds = Feed.find(:all, :limit => 100)
        end
        render_index
    end

    def search
        @feeds = Feed.search(params[:search_terms], {:limit => 100})
        render_index
    end

    # GET /feeds/1
    # GET /feeds/1.xml
    def show

        @feed = Feed.find(params[:id]) rescue nil
        @page_title = @feed.title unless @feed.nil?
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
        uri = params[:feed][:uri]
        #@feed = Feed.find_by_uri(uri)

        #if @feed.nil?
            @feed = Feed.new
            @feed.title = params[:feed][:title]
            @feed.uri = uri
            success = @feed.save
        # else
        #             success = true
        #         end
        
        respond_to do |format|
            if success
                flash[:notice] = 'Feed was successfully added.'
                @user.feeds << @feed
                format.html { redirect_to( user_feeds_path(@user) ) }
                format.xml  { render :xml => @feed }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @feed.errors }
            end        
        end

    end

    # PUT /feeds/1
    # PUT /feeds/1.xml
    def update
        @feed = Feed.find(params[:id])

        respond_to do |format|
            if @feed.update_attributes(params[:feed])
                flash[:notice] = 'Feed was successfully updated.'
                format.html { redirect_to( user_feeds_path(@user) ) }
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
        
        @feed = @user.feeds.find(params[:id])
        
        unless @feed.nil?
            @feed.destroy
            flash[:notice] = 'Feed was successfully deleted.'
        end
        
        respond_to do |format|
            format.html { redirect_to(user_feeds_path(@user)) }
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
        @user = User.find(params[:user_id]) rescue nil
    end

end
