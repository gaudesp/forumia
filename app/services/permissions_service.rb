class PermissionsService

  def self.can_access_to_forum?(user, forum)
    user_priority_permission = user ? user.role.permission.priority_permission : 1
    if !user && forum.role.permission.priority_permission == 1 ||
      user_priority_permission >= forum.role.permission.priority_permission
      return true
    end
    return false
  end

end
