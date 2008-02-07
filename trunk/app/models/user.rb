class User < ActiveRecord::Base
    include OpenAccount::OpenAccountModel
    
    has_many :feeds
    
    def is_in_role?(roles)
        
        # admins get a free pass            
        return true if self.role == 'admin'
        
        return false  
    end

end
