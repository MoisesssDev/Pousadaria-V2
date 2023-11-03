class GuesthousesController < ApplicationController
  def new
    @guesthouse = Guesthouse.new
  end

  def create
    @user = current_user
    @guesthouse = Guesthouse.new(guesthouse_params)
    @guesthouse.user = @user
    
    
    if @guesthouse.save
      @user.guesthouse_id = @guesthouse.id
      redirect_to root_path, notice: "Pousada cadastrada com sucesso"     
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @guesthouse = Guesthouse.find(
    params[:id]
    )
  end
  private

  def guesthouse_params
    params.require(:guesthouse).permit(:name, :legal_name, :cnpj, :phone, :email, 
                                       :address, :district, :state, :city, :cep, 
                                       :description, :accepted_payment_methods, 
                                       :accepts_pets, :policies, :check_in_time, :check_out_time)
  end
end
