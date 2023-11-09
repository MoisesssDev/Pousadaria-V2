class CustomPricesController < ApplicationController

  def new
    @custom_price = CustomPrice.new
    @rooms = current_user.guesthouse.rooms
  end

  def create
    @guesthouse = current_user.guesthouse
    @custom_price = CustomPrice.new(custom_price_params)
    
    if custom_price_overlaps?(@custom_price)

      redirect_to room_path(@custom_price.room_id), notice: "Já existe um preço definido para essa data"

    else
      if @custom_price.save
        redirect_to room_path(@custom_price.room_id), notice: "Preço personalizado adicionado com sucesso."
      else
        render "new", status: :unprocessable_entity
      end
    end
  end

  private

  def custom_price_overlaps?(custom_price)
    room = Room.find(custom_price.room_id)
    existing_prices = room.custom_prices
    new_price_range = custom_price.start_date..custom_price.end_date

    existing_prices.any? do |price|
      price_range = price.start_date..price.end_date
      price_range.overlaps?(new_price_range)
    end
  end

  def custom_price_params
    params.require(:custom_price).permit(:start_date, :end_date, :price, :room_id)
  end

end
