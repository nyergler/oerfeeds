class UsersController < ApplicationController
    layout "default"
    include OpenAccount::OpenAccountController

    # GET /entries
    # GET /entries.xml
    def index
        @users = User.find(:all)

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @users }
        end
    end
    
    def create
        session[:return_to] = '/welcome'
        super
    end
    
    def welcome
       respond_to do |format|
            format.html
            format.xml  { render :xml => current_user, :status => :created, :location => current_user }
        end
        
    end
    
    # GET /users/1
    # GET /users/1.xml
    def show
        @user = User.find(params[:id])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @user }
        end
    end

end
