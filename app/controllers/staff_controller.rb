class StaffController < ApplicationController

  def index
    @roles = Role.joins(:permission).all.where.not(id: 1).order(priority_permission: :asc)
    @role = Role.new
  end
  
end
