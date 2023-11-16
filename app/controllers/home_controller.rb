class HomeController < ApplicationController
  def index
    @user = current_user
    @guesthouses_recent = Guesthouse.active.recent(3)
    @guesthouses_all = Guesthouse.active.where.not(id: @guesthouses_recent.pluck(:id))
    
    if user_signed_in? && @user.owner? && @user.guesthouse.nil?
      redirect_to new_guesthouse_path
    end
  end
end
