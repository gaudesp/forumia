class NotificationsController < ApplicationController

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update_attribute(:read_at, Time.current) if current_user == notification.recipient || notification.read_at.nil?
    redirect_to forum_topic_path(notification.notifiable.topic.forum, notification.notifiable.topic, page: notification.notifiable.page) + "##{notification.notifiable.id}"
  end

end
