class MobilePaymentsController < ApplicationController
  before_action :set_mobile_payment, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]
  before_action :authenticate_user!

  # GET /mobile_payments
  # GET /mobile_payments.json
  def index
    @mobile_payments = MobilePayment.all
  end

  # GET /mobile_payments/1
  # GET /mobile_payments/1.json
  def show
  end

  # GET /mobile_payments/new
  def new
    @mobile_payment = MobilePayment.new
  end

  # GET /mobile_payments/1/edit
  def edit
  end

  # POST /mobile_payments
  # POST /mobile_payments.json
  def create
    @method = MobilePayment.new(mobile_payment_params)
    @method.verify_data_saved

    if @method.bank != ""
      unless @method.country.capitalize != current_user.country.capitalize || current_user.is_admin? 
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @method.country != "Venezuela"
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @mobile_payment = current_user.mobile_payments.create(mobile_payment_params)
      
          respond_to do |format|
            if @mobile_payment.save
              format.html { redirect_to payment_methods_path, notice: 'Pago Movil registrado con exito.' }
              format.json { render :show, status: :created, location: @mobile_payment }
            else
              format.html { render :new }
              format.json { render json: @mobile_payment.errors, status: :unprocessable_entity }
            end
          end 
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to set_method_path, notice: 'Ha seleccionado opciones invalidas.' }
      end
    end
  end  

  # PATCH/PUT /mobile_payments/1
  # PATCH/PUT /mobile_payments/1.json
  def update
    respond_to do |format|
      if @mobile_payment.update(mobile_payment_edit_params)
        if @mobile_payment.status === "activo"
          mensaje = 'Pago movil activado con exito.'
        else
          mensaje = 'Pago movil inactivado con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje }
        format.json { render :show, status: :ok, location: @mobile_payment }
      else
        format.html { render :edit }
        format.json { render json: @mobile_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobile_payments/1
  # DELETE /mobile_payments/1.json
  def destroy
    if @mobile_payment.user.id === current_user.id
      if current_user.is_admin?
        
        transactions = Transaction.where(account_destinity_admin: "mobile_payments-#{@mobile_payment.id}")
        if transactions.count > 0
          permit_delete = "only_user"
        else
          permit_delete = "permit"
        end
      
      else
        transactions = current_user.transactions.where("status LIKE ? OR status LIKE ? OR status LIKE ?", "en proceso", "envio en proceso", "por confirmar")
        permit_delete = ""
        transactions.each do |transaction|
          array_account = transaction.account_destinity_usuario.split(",")
          array_account.each do |account|
            if account === "mobile_payments-#{@mobile_payment.id}"
              permit_delete = "denied"
              break  
            end
          end
  
          if permit_delete === "denied"
            break
          end
        end
  
        if permit_delete != "denied"
          
          current_user.transactions.each do |transaction|
            array_account = transaction.account_destinity_usuario.split(",")
            array_account.each do |account|
              if account === "mobile_payments-#{@mobile_payment.id}"
                permit_delete = "only_user"
                break  
              end
            end
  
            if permit_delete === "only_user"
              break
            end
          end
  
          if permit_delete != "only_user"
            permit_delete = "permit"
          end
        end
  
      end
  
      if permit_delete === "denied"
        respond_to do |format|
          format.html { redirect_to payment_methods_path, alert: 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción en proceso.' }
          format.json { head :no_content }
        end
      elsif permit_delete === "only_user"
        @mobile_payment.update(view:"false")
        respond_to do |format|
          format.html { redirect_to payment_methods_path, notice: 'Pago Móvil eliminado con exito.' }
          format.json { head :no_content }
        end
      elsif permit_delete === "permit"
        @mobile_payment.destroy
        respond_to do |format|
          format.html { redirect_to payment_methods_path, notice: 'Pago Móvil eliminado con exito.' }
          format.json { head :no_content }
        end
      end
  
    else
      respond_to do |format|
        format.html { redirect_to payment_methods_path, alert: 'Acción no permitida.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_payment
      @mobile_payment = MobilePayment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mobile_payment_params
      params.require(:mobile_payment).permit(:country, :name, :second_name, :last_name, :bank, :number_phone, :document)
    end

    def mobile_payment_edit_params
      params.require(:mobile_payment).permit(:status)
    end
end
