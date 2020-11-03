class MobilePaymentsController < ApplicationController
  before_action :set_mobile_payment, only: [:destroy]

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
      if @method.country.capitalize === current_user.country.capitalize 
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
          @mobile_payment.modifyDocument
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
      if @mobile_payment.update(mobile_payment_params)
        format.html { redirect_to @mobile_payment, notice: 'Mobile payment was successfully updated.' }
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
    @mobile_payment.destroy
    respond_to do |format|
      format.html { redirect_to payment_methods_path, notice: 'Mobile payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_payment
      @mobile_payment = MobilePayment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mobile_payment_params
      params.require(:mobile_payment).permit(:country, :bank, :number_phone, :document)
    end
end
