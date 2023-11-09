class CustomPricesController < ApplicationController

  def new
    @custom_price = CustomPrice.new
    @rooms = current_user.guesthouse.rooms
  end

  def create
    @custom_price = CustomPrice.new(custom_price_params)

    if @custom_price.save
      redirect_to room_path(@custom_price.room_id), notice: "Preço personalizado adicionado com sucesso."
    else
      render :new
    end
  end

  private

  def custom_price_params
    params.require(:custom_price).permit(:start_date, :end_date, :price, :room_id)
  end

end
