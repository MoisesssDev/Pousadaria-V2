class HomeController < ApplicationController
  def index
    @user = current_owner
    @guesthouses_recent = Guesthouse.active.recent(3)
    @guesthouses_all = Guesthouse.active.where.not(id: @guesthouses_recent.pluck(:id))
    
    if owner_signed_in? && @user.guesthouse.nil?
      redirect_to new_guesthouse_path
    end
  end
end
