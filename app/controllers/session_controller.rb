# This controller handles the login/logout function of the site.
class SessionController < ApplicationController
    include OpenAccount::OpenSessionController
    layout "default"
    
    protected
    
    def successful_login(new_user)
        logger.info "sucessful login for #{self.current_user.login}"
        get_event
        
        if !@event.nil?
            redirect_back_or_default(@event)
        else
            redirect_back_or_default(events_url)
        end
        
        flash[:notice] = "#{self.current_user.login} Logged in successfully"
        if new_user
            send_welcome
        end
    end
    
end
