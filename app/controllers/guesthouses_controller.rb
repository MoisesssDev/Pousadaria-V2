class GuesthousesController < ApplicationController
  def new
    @guesthouse = Guesthouse.new
  end

  def create
    @guesthouse = Guesthouse.new(guesthouse_params)
    @guesthouse.user = current_user
    
    if @guesthouse.save
      redirect_to root_path, notice: "Pousada cadastrada com sucesso"     
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def guesthouse_params
    params.require(:guesthouse).permit(:name, :legal_name, :cnpj, :phone, :email, 
                                       :address, :district, :state, :city, :cep, 
                                       :description, :accepted_payment_methods, 
                                       :accepts_pets, :policies, :check_in_time, :check_out_time)
  end
end
