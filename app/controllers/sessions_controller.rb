# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
    include OpenAccount::OpenSessionController
    layout "default"
    
    protected
    
    def successful_login(new_user)
        logger.info "sucessful login for #{self.current_user.login}"
        
        redirect_back_or_default('')
        
        flash[:notice] = "#{self.current_user.login} Logged in successfully"
        if new_user
            send_welcome
        end
    end
    
end
