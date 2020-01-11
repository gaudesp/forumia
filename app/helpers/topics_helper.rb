module TopicsHelper

  def display_topic_status(status)
    case status
      when 1 then fa_icon "lock"
      when 2 then fa_icon "thumbtack"
      when 3 then fa_icon "thumbtack"
      else fa_icon "folder", class: "text-warning"
    end
  end

end
