class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  	if @user.save
  		Signup.confirm_email(@user).deliver
      redirect_to @user, notice: 'Cadastro criado com sucesso!'
  	else
  		render action: :new
  	end
  end

  def edit
    user_find
  end

  def update
    user_find
    if @user.update(user_params)
     	redirect_to @user, notice: 'Cadastro atualizado com sucesso!'
    else
  		render action: :edit
    end
  end

  def show
  	user_find
  end

  # --------- #
  private

  def user_params
  	# Os "pontos" no final da linha não são opcionais!
  	# Fazem parte da interface fluente
  	params.
  	  require(:user).
  	    permit(:email, :full_name, :location, :password, :password_confirmation, :bio)
  end

  def user_find
  	@user = User.find(params[:id])
  end
   
end