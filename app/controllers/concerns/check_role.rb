module CheckRole

    extend ActiveSupport::Concern
  
    included do
      before_action :is_not_webmaster
    end
  
    private
  
    def is_not_webmaster
      !current_user || current_user.role.permission.priority_permission != 100
    end
  
  end
  