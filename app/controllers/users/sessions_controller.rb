# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :set_last_seen_at, only: :destroy

  private

  def set_last_seen_at
    current_user.update_attribute(:last_seen_at, Time.now-5.minutes) if current_user
  end

end
