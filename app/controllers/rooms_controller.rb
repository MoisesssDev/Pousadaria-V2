class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @guesthouse = current_user.guesthouse
    @room = @guesthouse.rooms.build(room_params)

    if @room.save
      redirect_to guesthouse_path(@guesthouse), notice: "Quarto cadastrada com sucesso"     
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(
      :name, :description, :dimension, :max_occupancy, :daily_rate,
      :has_private_bathroom, :has_balcony, :has_air_conditioning, :has_tv,
      :has_wardrobe, :is_accessible, :has_cofre, :available
    )
  end
end
