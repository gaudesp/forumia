class HomeController < ApplicationController

  def index
    @user_count = User.count
    @users = User.all.order(created_at: :desc).limit(5)
  end
  
end
