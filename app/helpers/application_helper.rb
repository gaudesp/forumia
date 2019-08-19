module ApplicationHelper

  def flash_class(level)
    case level
      when 'notice' then "alert alert-success"
      when 'success' then "alert alert-success"
      else "alert alert-danger"
    end
  end

  def flash_icon(level)
    case level
      when 'notice' then "check-circle"
      when 'success' then "check-circle"
      else "exclamation-circle"
    end
  end

  def display_date(date)
    return date.strftime("%d/%m/%Y")
  end

  def display_avatar(user)
    return fa_icon("user-circle", class: "icon-md") if !user || !user.avatar.present?
    image_tag(user.avatar, class: "avatar")
  end

end
