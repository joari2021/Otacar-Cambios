class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin!, only: [:destroy] 
  
  def edit
    @users = User.all
  end

  def create
    @user = User.new(sign_up_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to register_succesfull_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def sign_up_params
    
    params.require(:user).permit(:email, :document, :password, :password_confirmation)
  end

  def account_update_params
    if current_user.is_normal_user?
      params.require(:user).permit(:phone, :address, :password, :password_confirmation, :current_password)
    elsif current_user.is_new_user?  
      params.require(:user).permit(:name, :last_name, :phone, :day, :month, :year, :gender, :country, :state, :city, :address, :password, :password_confirmation, :current_password, :second_name, :second_surname, :num_user)
    end
    
  end

end