class Api::V1::GuesthousesController < ApplicationController

  def show
    begin
      guesthouse = Guesthouse.find(params[:id])
      render status: :ok, json: guesthouse.as_json(except: [:created_at, :updated_at])

    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: { message: "Pousada não encontrada" }
    end
    
  end

end