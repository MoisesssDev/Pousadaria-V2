class ReviewsController < ApplicationController

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @review = @reservation.build_review(review_params)

    if @review.save
      redirect_to reservations_path, notice: "Avaliação cadastrada com sucesso"
    else
      render "reservations/show", status: :unprocessable_entity, notice: "Não foi possível cadastrar sua avaliação"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end

end