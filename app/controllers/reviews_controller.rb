class ReviewsController < ApplicationController

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @review = @reservation.build_review(review_params)
    @review.guesthouse = @reservation.guesthouse

    if @review.save
      redirect_to reservations_path, notice: "Avaliação cadastrada com sucesso"
    else
      flash[:notice] = "Não foi possível cadastrar sua avaliação"
      render "reservations/show", status: :unprocessable_entity 
    end
  end

  def index
    if owner_signed_in?
      @guesthouse = Guesthouse.find(params[:guesthouse_id])
      @reviews = @guesthouse.reviews
    end
    
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end