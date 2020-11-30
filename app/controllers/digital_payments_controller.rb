class DigitalPaymentsController < ApplicationController
  before_action :set_digital_payment, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]

  # GET /digital_payments
  # GET /digital_payments.json
  def index
    @digital_payments = DigitalPayment.all
  end

  # GET /digital_payments/1
  # GET /digital_payments/1.json
  def show
  end

  # GET /digital_payments/new
  def new
    @digital_payment = DigitalPayment.new
  end

  # GET /digital_payments/1/edit
  def edit
  end

  # POST /digital_payments
  # POST /digital_payments.json
  def create
    @method = DigitalPayment.new(digital_payment_params)
    @method.verify_data_saved

    if @method.payment_method != ""
      unless @method.country.capitalize != current_user.country.capitalize || current_user.is_admin?  
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @method.country != "Colombia"
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @digital_payment = current_user.digital_payments.create(digital_payment_params)
          respond_to do |format|
            if @digital_payment.save
              format.html { redirect_to payment_methods_path, notice: 'Pago Digital guardado con exito.' }
              format.json { render :show, status: :created, location: @digital_payment }
            else
              format.html { render :new }
              format.json { render json: @digital_payment.errors, status: :unprocessable_entity }
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

  # PATCH/PUT /digital_payments/1
  # PATCH/PUT /digital_payments/1.json
  def update
    respond_to do |format|
      if @digital_payment.update(digital_payment_edit_params)
        if @digital_payment.status === "activo"
          mensaje = 'Pago Digital activado con exito.'
        else
          mensaje = 'Pago Digital inactivado con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje }
        format.json { render :show, status: :ok, location: @digital_payment }
      else
        format.html { render :edit }
        format.json { render json: @digital_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digital_payments/1
  # DELETE /digital_payments/1.json
  def destroy
    if @digital_payment.permit_delete === "denied"
      respond_to do |format|
        format.html { redirect_to payment_methods_path, alert: 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción y debe terminar las transacciones que tenga en proceso para poder eliminarla.' }
        format.json { head :no_content }
      end
    elsif @digital_payment.permit_delete === "only_user"
      @digital_payment.update(view:"false")
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Pago Digital eliminado con exito.' }
        format.json { head :no_content }
      end
    else
      @digital_payment.destroy
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Pago Digital eliminado con exito.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digital_payment
      @digital_payment = DigitalPayment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def digital_payment_params
      params.require(:digital_payment).permit(:country, :name, :last_name, :number_phone, :payment_method)
    end

    def digital_payment_edit_params
      params.require(:digital_payment).permit(:status)
    end
end
