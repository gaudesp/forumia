class ForumsController < ApplicationController

  def index
    @categories = Category.all
  end

  def panel
    @forums = Forum.all
  end

end
