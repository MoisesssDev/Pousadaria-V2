class Api::V1::GuesthousesController < ApplicationController

  def show
    begin
      guesthouse = Guesthouse.find(params[:id])
      rooms = guesthouse.rooms
      render status: :ok, json: guesthouse.as_json(except: [:created_at, :updated_at], include: :rooms)

    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: { message: "Pousada não encontrada" }
    end
    
  end

  def index
    guesthouses = Guesthouse.all.order(:name)

    if guesthouses.empty?
      render status: :not_found, json: { message: "Nenhuma pousada encontrada" }
    else
      render status: :ok, json: guesthouses.as_json(except: [:created_at, :updated_at])
    end

  end

end