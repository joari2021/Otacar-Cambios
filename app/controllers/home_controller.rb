class HomeController < ApplicationController
  before_action :authenticate_normal_user!
  before_action :authenticate_user!
  def index

    transactions = current_user.transactions.where(status: "realizada")
    @transactions_totales = transactions.count

    monto_total_send = 0.00
    transactions.each do |transaction|
      monto_total_send += transaction.monto_envio.to_f
    end
    @monto_total_send = monto_total_send

    if current_user.is_admin?
      @transactions = Transaction.all
      @users = User.all
    else
      @transactions = current_user.transactions.order("created_at DESC")
                                  .limit(5)
                                  .where status: "realizada"
    end
    
    @notifications = current_user.notifications.paginate(:page => params[:page], :per_page => 20).order("created_at DESC")

    #ACTUALIZAR LAS NOTIFICACIONES VISTAS
    notifications = @notifications.where(view:false)
    if notifications.count > 0
      notifications.update_all(view:true,updated_at: Time.now.utc)
    end

    #REFERIDOS
    num_usuario = current_user.id * 4
    @referidos = User.where(num_referidor: num_usuario.to_s,status_referencia: "confirmada")
    @referidos_sin_confirmar = User.where(num_referidor: num_usuario.to_s,status_referencia: "sin confirmar")
  end
  
  def calculate_shipping
    @rates = Rate.all
  end

  def mostrar_referido
    if params[:notify].present?
      notify = Notification.find(params[:notify])
      
      if notify.user_id === current_user.id && notify.asunto === "Referencia de usuario"
        usuario_a_referir = User.find(notify.dato_clave.to_i/4)
        if usuario_a_referir.status_referencia === "sin confirmar"
          @usuario_a_referir = usuario_a_referir
        else
          redirect_to user_root_path
        end
      else
        redirect_to user_root_path
      end
    else
      redirect_to user_root_path
    end
  end

  def confirm_referido
    if params[:notify].present?
      notify = Notification.find(params[:notify])
      
      if notify.user_id === current_user.id && notify.asunto === "Referencia de usuario"
        usuario_a_referir = User.find(notify.dato_clave.to_i/4)
        if usuario_a_referir.status_referencia === "sin confirmar"
          usuario_a_referir.update(status_referencia: "confirmada")
          redirect_to user_root_path, notice: "Tu recomendación ha sido procesada con exito. Gracias por recomendar nuestra página."
        else
          redirect_to user_root_path
        end
        
      else
        redirect_to user_root_path
      end
    else
      redirect_to user_root_path
    end
  end

  def rechazar_referido
    if params[:notify].present?
      notify = Notification.find(params[:notify])
      
      if notify.user_id === current_user.id && notify.asunto === "Referencia de usuario"

        usuario_a_referir = User.find(notify.dato_clave.to_i/4)
        if usuario_a_referir.status_referencia === "sin confirmar"
          usuario_a_referir.update(status_referencia: "rechazada")
          redirect_to user_root_path, notice: "La recomendación ha sido rechazada con éxito. Gracias por responder."
        else
          redirect_to user_root_path
        end
      else
        redirect_to user_root_path
      end
    else
      redirect_to user_root_path
    end
  end
end
