class HomeController < ApplicationController
  def index
    @page_title = "Home"
    @user = current_user
    
    if user_signed_in? && current_user.owner? && current_user.guesthouse_id.nil?
      redirect_to new_guesthouse_path
    end
  end
end
