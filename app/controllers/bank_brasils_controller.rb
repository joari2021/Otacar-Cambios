class BankBrasilsController < ApplicationController
  before_action :set_bank_brasil, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]
  before_action :authenticate_user!

  # GET /bank_brasils
  # GET /bank_brasils.json
  def index
    @bank_brasils = BankBrasil.all
  end

  # GET /bank_brasils/1
  # GET /bank_brasils/1.json
  def show
  end

  # GET /bank_brasils/new
  def new
    @bank_brasil = BankBrasil.new
  end

  # GET /bank_brasils/1/edit
  def edit
  end

  # POST /bank_brasils
  # POST /bank_brasils.json
  def create
    #@bank_brasil = BankBrasil.new(bank_brasil_params)
    @banco = BankBrasil.new(bank_brasil_params)
    @banco.verify_data_saved

    if @banco.bank != ""
      unless @banco.country.capitalize != current_user.country.capitalize || current_user.is_admin? 
         
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @banco.country != "Brasil" 
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @bank_brasil = current_user.bank_brasils.create(bank_brasil_params)
          @bank_brasil.modify_cpf
          respond_to do |format|
            if @bank_brasil.save
              format.html { redirect_to payment_methods_path, notice: 'Cuenta bancaria registrada con exito.' }
              format.json { render :show, status: :created, location: @bank_brasil }
            else
              format.html { render :new }
              format.json { render json: @bank_brasil.errors, status: :unprocessable_entity }
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

  # PATCH/PUT /bank_brasils/1
  # PATCH/PUT /bank_brasils/1.json
  def update
    respond_to do |format|
      if @bank_brasil.update(bank_brasil_edit_params)
        if @bank_brasil.status === "activo"
          mensaje = 'Cuenta Bancaria activada con exito.'
        else
          mensaje = 'Cuenta Bancaria inactivada con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje}
        format.json { render :show, status: :ok, location: @bank_brasil }
      else
        format.html { render :edit }
        format.json { render json: @bank_brasil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_brasils/1
  # DELETE /bank_brasils/1.json
  def destroy
    if @bank_brasil.permit_delete === "denied"
      respond_to do |format|
        format.html { redirect_to payment_methods_path, alert: 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción y debe terminar las transacciones que tenga en proceso para poder eliminarla.' }
        format.json { head :no_content }
      end
    elsif @bank_brasil.permit_delete === "only_user"
      @bank_brasil.update(view:"false")
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Cuenta Bancaria eliminada con exito.' }
        format.json { head :no_content }
      end
    else
      @bank_brasil.destroy
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Cuenta Bancaria eliminada con exito.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_brasil
      @bank_brasil = BankBrasil.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_brasil_params
      params.require(:bank_brasil).permit(:name, :last_name, :country, :cpf, :bank, :number_agency, :number_account)
    end

    def bank_brasil_edit_params
      params.require(:bank_brasil).permit(:status)
    end
end
