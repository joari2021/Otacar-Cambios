class DigitalPaymentsController < ApplicationController
  before_action :set_digital_payment, only: [:destroy]

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
    @digital_payment = current_user.digital_payments.create(digital_payment_params)
    
    if @digital_payment.country.capitalize === current_user.country.capitalize 
      respond_to do |format|
        format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
      end
    else 
      if @digital_payment.country != "Colombia"
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else
        @digital_payment.verify_data_saved
        
        respond_to do |format|
          if @digital_payment.save
            format.html { redirect_to payment_methods_path, notice: 'El Pago Digital ha sido guardado con exito.' }
            format.json { render :show, status: :created, location: @digital_payment }
          else
            format.html { render :new }
            format.json { render json: @digital_payment.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /digital_payments/1
  # PATCH/PUT /digital_payments/1.json
  def update
    respond_to do |format|
      if @digital_payment.update(digital_payment_params)
        format.html { redirect_to @digital_payment, notice: 'Digital payment was successfully updated.' }
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
    @digital_payment.destroy
    respond_to do |format|
      format.html { redirect_to digital_payments_url, notice: 'El Pago Digital ha sido registrado con exito.' }
      format.json { head :no_content }
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
end
