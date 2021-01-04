class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    parametros = notification_params
    
    alert = false
    notice = false

    #######  ENVIO A UN SOLO USUARIO #############
    if parametros["destinatarios"] === "uno"
      num_usuario = parametros["usuario"].to_i

      if num_usuario % 4 === 0
        num_usuario /= 4
        rastreo_usuario = User.where(id: num_usuario)

        unless rastreo_usuario.nil? || rastreo_usuario === 0
          usuario = User.find(num_usuario.to_i)
          notification = usuario.notifications.create(emisor:"Otacar Cambios",content:"#{parametros["content"]}",asunto:"#{parametros["asunto"]}")
          notification.save
          notice = true
          info = "La notificacion se envio al usuario que eligio con exito"
        else
          alert = true
          info = "El usuario destinatario no existe"
        end
      else
        alert = true
        info = "El usuario destinatario no existe"
      end

    ######### ENVIO A VARIOS USUARIOS ################
    elsif parametros["destinatarios"] === "varios"
      destinatarios = parametros["usuarios"].split(",")
      # Loops  
      var = 0
      usuario_no_find = []  
      while var < destinatarios.length  
        num_usuario = destinatarios[var].to_i
        
        if num_usuario % 4 === 0
          num_usuario /= 4
          rastreo_usuario = User.where(id: num_usuario)

          if rastreo_usuario.present?
            usuario = User.find(num_usuario)
            notification = usuario.notifications.create(emisor:"Otacar Cambios",content:"#{parametros["content"]}",asunto:"#{parametros["asunto"]}")
            notification.save
          else
            usuario_no_find << "#{destinatarios[var]}"
          end
          var += 1  
        else
          usuario_no_find << "#{destinatarios[var]}"
        end
          
      end
      if usuario_no_find.length === 0
        notice = true
        info = "La notificacion se envio a todos los usuarios que eligio con exito"
      elsif usuario_no_find.length > 0 && usuario_no_find.length < destinatarios.length
        alert = true
        info = "La notificacion se envio a todos los usuarios excepto a: #{usuario_no_find.join(', ')}"
      else 
        alert = true
        info = "La Notificación no fue enviada porque ninguno de los usuarios existe" 
      end

    ############# ENVIO A TODOS LOS USUARIOS #########################
    elsif parametros["destinatarios"] === "todos"
      users = User.all

      users.each do |usuario|
        notification = usuario.notifications.create(emisor:"Otacar Cambios",content:"#{parametros["content"]}",asunto:"#{parametros["asunto"]}")
        notification.save
        notice = true
        info = "La notificacion se envio a todos los usuarios con exito"
      end
    else
      alert = true
      info = "La notificacion no se envio a ningun usuario"
    end

    if notice
      respond_to do |format|
        format.html { redirect_to user_root_url, notice: info }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_notification_url, alert: info }
        format.json { head :no_content }
      end
    end
    
=begin
    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notificación enviada con exito.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to user_root_url, notice: 'Notificación eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:destinatarios,:usuario,:usuarios,:content,:asunto)
    end
end
