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

  def display_distance_between(date)
    return distance_of_time_in_words(date, Time.now)
  end

  def display_avatar(user, page = nil)
    if page == "profile"
      return "https://image.noelshack.com/fichiers/2019/34/4/1566466131-default-background.png" if !user || !user.avatar.present?
      user.avatar
    else
      return fa_icon("user-circle", class: "icon-md") if !user || !user.avatar.present?
      image_tag(user.avatar, class: "avatar")
    end
  end

  def display_background(user)
    return "https://image.noelshack.com/fichiers/2019/34/3/1566384422-photo-1554135216-0802998080d7.jpeg" if !user || !user.background.present?
    user.background
  end

  def display_music(user)
    return "<iframe id='popup-youtube-player' width='0' height='0' src='https://www.youtube.com/embed/#{VideoInfo.new(user.music).video_id}?enablejsapi=1&version=3&playerapiid=ytplayer&rel=0&autoplay=1' frameborder='0' allowfullscreen='true' allowscriptaccess='always'></iframe>".html_safe if user.music.present?
  end

  def display_player(user)
    return link_to "#", class: "float-right player", id: "stop" do fa_icon "pause" end if user.music.present?
  end

end
