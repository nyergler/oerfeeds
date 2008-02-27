# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
    def can_view?(user, roles, &block)
        if logged_in? && user.is_in_role?(roles)
            content = capture(&block)
            concat(content, block.binding)
        end
    end

    def is_my_profile?(user, &block)
        if logged_in? && (current_user.id == user.id)
            content = capture(&block)
            concat(content, block.binding)
        end 
    end
    
    def can_view_or_is_owner?(user, item, roles, &block)
        if logged_in? && (user.is_in_role?(roles) || item.user_id == user.id)
            content = capture(&block)
            concat(content, block.binding)
        end
    end
        
    def is_edit_form?(&block)
        if defined?(@edit) && @edit
            content = capture(&block)
            concat(content, block.binding)
        end
    end
    
    def logged_in_view?(&block)
        if logged_in?
            content = capture(&block)
            concat(content, block.binding)
        end
    end
    
    def logged_out_view?(&block)
        if !logged_in?
            content = capture(&block)
            concat(content, block.binding)
        end
    end
    
    # Use to protect a method from unauthorized access
    def restrict_access(user, roles)
        redirect_to "/not_authorized" unless logged_in? && user.is_in_role?(roles)
    end
    
    def user_admin_links
        if current_user
            'Welcome ' + link_to(current_user.login || 'ME', current_user) + '<br />' + link_to('sign out', logout_url)
        else
            link_to('sign in', login_url) + " " + link_to('sign up', signup_url)
        end
    end
    
end
