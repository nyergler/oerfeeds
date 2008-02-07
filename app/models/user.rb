class User < ActiveRecord::Base
    include OpenAccount::OpenAccountModel
    
    has_many :feeds_users
    has_many :feeds, :through => :feeds_users
    
    def is_in_role?(roles)
        
        # admins get a free pass            
        return true if self.role == 'admin'
        
        return false  
    end

end
