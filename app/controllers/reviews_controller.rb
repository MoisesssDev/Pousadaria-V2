class ReviewsController < ApplicationController

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @review = @reservation.build_review(review_params)
    @review.guesthouse = @reservation.guesthouse

    if @review.save
      redirect_to room_reservation_path(@review.reservation.room, @review.reservation), notice: "Avaliação cadastrada com sucesso"
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

  def show
    @review = Review.find(params[:id])
  end

  def response_to_review
    @review = Review.find(params[:review_id])
    response = params[:review][:response_to_review]

    if @review.update(response_to_review: response )
      redirect_to room_reservation_path(@review.reservation.room, @review.reservation), notice: "Resposta enviada com sucesso"
    else
      flash[:notice] = "Não foi possível enviar a resposta"
      render "reviews/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end