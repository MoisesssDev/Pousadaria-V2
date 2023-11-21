class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @guesthouse = current_owner.guesthouse
    @room = @guesthouse.rooms.build(room_params)

    if @room.save
      redirect_to guesthouse_path(@guesthouse), notice: "Quarto cadastrada com sucesso"  
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @room = Room.find(
    params[:id]
    )
  end

  def update
    @room = Room.find(params[:id])
    @guesthouse = current_owner.guesthouse

    if @room.update(room_params)
      redirect_to guesthouse_path(@guesthouse), notice: "Quarto atualizado com sucesso"
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def index
    @guesthouse = current_owner.guesthouse
    @rooms_unavailable = @guesthouse.rooms.where(available: false)
  end

  def show
    @room = Room.find(params[:id])
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
