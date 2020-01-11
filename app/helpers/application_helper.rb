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
    date = date.strftime("%d/%m/%Y")
    return date
  end

  def display_datetime(date)
    return date.strftime("%d/%m/%Y %H:%M:%S")
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
    return date ? distance_of_time_in_words(date, Time.now) : "Non renseigné"
  end
  def display_music(user)
    return "<div class='mt-2 embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item'' id='popup-youtube-player' style='width:100%;height:400px' src='https://www.youtube.com/embed/#{VideoInfo.new(user.music).video_id}?enablejsapi=1&version=3&playerapiid=ytplayer&rel=0&autoplay=1' frameborder='0' allowfullscreen='true' allowscriptaccess='always'></iframe></div>".html_safe if user.music.present?
  end
  
end
