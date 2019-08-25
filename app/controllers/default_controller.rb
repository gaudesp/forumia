class DefaultController < ApplicationController
  before_action :redirect

  def redirect
    redirect_to home_index_path
  end

end
