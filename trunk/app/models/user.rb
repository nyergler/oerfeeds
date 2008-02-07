class User < ActiveRecord::Base
    include OpenAccount::OpenAccountModel
    
    has_many :feeds, :through => :feeds_users
    
    def is_in_role?(event, roles)
        
        # admins get a free pass            
        return true if self.role == 'admin'
        
        return false  
    end

end