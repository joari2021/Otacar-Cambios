class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin!, only: [:destroy]
  before_action :authenticate_referidor!, only: [:update] 
  before_action :authenticate_user!, only: [:update,:destroy]
  
  def edit 
  end

  def create
      super
=begin
    @user = User.new(sign_up_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_registration_path, notice: "Bienvenido. Debes completar el registro para poder utilizar nuestros servicios" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  def update
    
    unless current_user.is_admin?
      super

      if resource.errors.count === 0 && @user.status_referencia === "indefinido"
          num_referidor = @user.num_referidor.to_i
          @user.update(num_referidor:"#{num_referidor}",status_referencia:"sin confirmar")
          num_referidor /= 4
          usuario = User.find(num_referidor)
          notification = usuario.notifications.create(emisor:"#{@user.name.capitalize} #{@user.last_name.capitalize}",content:"Gracias por recomendar nuestra pagina a este usuario, ahora debes confirmar que es tu referido.",asunto:"Referencia de usuario",dato_clave:"#{@user.id*4}")
          notification.save
      end
      
    else
      parametros = account_update_params_user
      usuario_edit = User.find(parametros["id"])
      
      if usuario_edit.is_admin?
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
  end

  def destroy
  
    usuario = User.find_by(id: params["usuario"]["id"].to_i)

    if usuario.present?
      unless  usuario.is_admin?
        usuario.notifications.destroy_all
        usuario.transactions.destroy_all
        usuario.banks.destroy_all
        usuario.bank_brasils.destroy_all
        usuario.wallets.destroy_all
        usuario.wallet_with_users.destroy_all
        usuario.digital_payments.destroy_all
        usuario.mobile_payments.destroy_all
  
        #DELETE DE NOTIFICATION DEL USUARIO
        id = usuario.id * 4
        notifications = Notification.where(dato_clave: id)
        notifications.destroy_all 
        #END
        
        respond_to do |format|
          if usuario.destroy
            format.html { redirect_to user_root_path, notice: "El usuario fue eliminado con exito." }
          else
            format.html { render edit_user_registration_path, alert: "El usuario no pudo ser eliminado, contacte con soporte para resolver el problema." }
          end
        end
      else
        redirect_to user_root_path, alert: "Esta opcion no esta disponible para ti debido a que eres un administrador."
      end
    else
      redirect_to user_root_path, alert: "El usuario es Invalido o esta opcion no esta disponible para ti."
    end

  end

  private
  
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :num_referidor)
  end

  def account_update_params
    if current_user.is_normal_user?
      unless current_user.is_admin?
        params.require(:user).permit(:phone, :address, :password, :password_confirmation, :current_password)
      else
        params.require(:user).permit(:name, :last_name, :document, :phone, :day, :month, :year, :gender, :country, :state, :city, :address, :password, :password_confirmation, :current_password, :second_name, :second_surname)
      end
    elsif current_user.is_new_user? 
      params.require(:user).permit(:name, :last_name, :document, :phone, :day, :month, :year, :gender, :country, :state, :city, :address, :password, :password_confirmation, :current_password, :second_name, :second_surname, :num_referidor)
    end
  end

  def account_update_params_user
    params.require(:user).permit(:email, :name, :last_name, :document, :address, :phone, :day, :month, :year, :gender, :country, :state, :city, :second_name, :second_surname, :id)
  end
end