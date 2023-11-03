class HomeController < ApplicationController
  def index
    @page_title = "Home"
    @user = current_user
    @guesthouses = Guesthouse.all
    
    if user_signed_in? && @user.owner? && @user.guesthouse.nil?
      redirect_to new_guesthouse_path
    end
  end
end
