class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin!, only: [:destroy]
  before_action :authenticate_referidor!, only: [:update] 
  
  def edit
    

    unless current_user.num_referidor.nil?
      num_referidor = current_user.num_referidor.to_i / 4
      referidor = User.where(id: num_referidor)
    end
    
    unless referidor.nil? || !referidor.present?
      referidor = User.find(num_referidor)

      if referidor.is_normal_user? 
        @referidor = referidor
      end
    end
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

  def update
      
    unless @user.is_admin?
      super
    else
      parametros = account_update_params_user
      usuario_edit = User.find_by(document: parametros["document"])

      if @user.document === usuario_edit.document
        super
      else
        respond_to do |format|
          if usuario_edit.update(account_update_params_user)
            format.html { redirect_to user_root_path, notice: "El perfil del usuario fue actualzado con exito." }
          else
            format.html { render edit_user_registration_path }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      end
    end
    
    if @user.status_referencia === "indefinido"
      num_referidor = @user.num_referidor.to_i
      @user.update(num_referidor:"#{num_referidor}",status_referencia:"sin confirmar")
      num_referidor /= 4
      usuario = User.find(num_referidor)
      notification = usuario.notifications.create(emisor:"#{@user.name.capitalize} #{@user.last_name.capitalize}",content:"Gracias por recomendar nuestra pagina a este usuario, ahora debes confirmar que es tu referido.",asunto:"Referencia de usuario",dato_clave:"#{@user.id*4}")
      notification.save
    end
    
=begin
    respond_to do |format|
      if @user.update(account_update_params) && @user.update(num_referidor: num_referidor.to_s)
        num_referidor /= 4
        usuario = User.find(num_referidor)
        notification = usuario.notifications.create(emisor:"#{usuario.name.capitalize} #{usuario.last_name.capitalize}",content:"Gracias por recomendar nuestra pagina a este usuario, ahora debes confirmar que es tu referido",asunto:"#{parametros["asunto"]}")
        notification.save

        format.html { redirect_to user_root_path, notice: "Su registro ha sido completado con exito" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :num_referidor)
  end

  def account_update_params
    if current_user.is_normal_user?
      params.require(:user).permit(:phone, :address, :password, :password_confirmation, :current_password)
    elsif current_user.is_new_user? 
      params.require(:user).permit(:name, :last_name, :document, :phone, :day, :month, :year, :gender, :country, :state, :city, :address, :password, :password_confirmation, :current_password, :second_name, :second_surname, :num_referidor)
    end
  end

  def account_update_params_user
    params.require(:user).permit(:email, :name, :last_name, :document, :address, :phone, :day, :month, :year, :gender, :country, :state, :city, :second_name, :second_surname, :num_referidor)
  end
end