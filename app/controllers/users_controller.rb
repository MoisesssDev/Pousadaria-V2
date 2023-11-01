class UsersController < ApplicationController
  def new
    @page_title = "Cadastro"
    @user = User.new  
  end

  def create
    @page_title = "Cadastro"
    @user = User.new(user_params) 

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_guesthouse_path, notice: "Conta criada com sucesso" }
      else
        flash.now[:notice] = "Não foi possivel criar a conta"
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
