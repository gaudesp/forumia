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

  def display_gender(gender)
    case gender
      when 0 then "Homme"
      when 1 then "Femme"
      else "Autre"
    end
  end
  
  def display_role_grade(role)
    return "<span class='badge p-1' style='color:#fff;background-color:#{role.color}'>#{fa_icon(role.icon)} #{role.label}</span>".html_safe
  end
  
  def display_role_user(user)
    return "<span class='badge p-1' style='color:#fff;background-color:#{user.role.color}'>#{user.username}</span>".html_safe
  end

  def display_distance_between(date)
    return distance_of_time_in_words(date, Time.now)
  end

  def display_avatar(user, page = nil)
    if page == "profile"
      return "https://image.noelshack.com/fichiers/2019/34/4/1566466264-anonymous-user.png" if !user || !user.avatar.present?
      user.avatar
    else
      return fa_icon("user-circle", class: "icon-md ml-3") if !user || !user.avatar.present?
      image_tag(user.avatar, class: "avatar")
    end
  end

  def display_background(user)
    return "https://image.noelshack.com/fichiers/2019/34/4/1566466131-default-background.png" if !user || !user.background.present?
    user.background
  end

  def display_music(user)
    return "<div class='embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item' mt-2' id='popup-youtube-player' style='width:100%;height:400px' src='https://www.youtube.com/embed/#{VideoInfo.new(user.music).video_id}?enablejsapi=1&version=3&playerapiid=ytplayer&rel=0&autoplay=1' frameborder='0' allowfullscreen='true' allowscriptaccess='always'></iframe></div>".html_safe if user.music.present?
  end
  
end
