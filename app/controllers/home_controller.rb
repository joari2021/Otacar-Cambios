class HomeController < ApplicationController
  before_action :authenticate_normal_user!
  def index
    transactions = current_user.transactions.where(status: "realizada")
    @transactions_totales = transactions.count

    monto_total_send = 0.00
    transactions.each do |transaction|
      monto_total_send += transaction.monto_envio.to_f
    end
    @monto_total_send = monto_total_send

    @transactions = current_user.transactions.order("created_at DESC").limit(5)

    @notifications = current_user.notifications.order("created_at DESC")

    #ACTUALIZAR LAS NOTIFICACIONES VISTAS
    notifications = @notifications.where(view:false)
    if notifications.count > 0
      notifications.update_all(view:true,updated_at: Time.now.utc)
    end
  end
  
  def calculate_shipping
    @rates = Rate.all
  end
end
