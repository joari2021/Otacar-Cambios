class BankBrasilsController < ApplicationController
  before_action :set_bank_brasil, only: [:destroy]

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
    @bank_brasil = current_user.bank_brasils.create(bank_brasil_params)
    
    if @bank_brasil.country.capitalize === current_user.country.capitalize 
      respond_to do |format|
        format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
      end
    else 
      if @bank_brasil.country != "Brasil"
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else
        @bank_brasil.verify_data_save
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
  end

  # PATCH/PUT /bank_brasils/1
  # PATCH/PUT /bank_brasils/1.json
  def update
    respond_to do |format|
      if @bank_brasil.update(bank_brasil_params)
        format.html { redirect_to @bank_brasil, notice: 'Bank brasil was successfully updated.' }
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
    @bank_brasil.destroy
    respond_to do |format|
      format.html { redirect_to payment_methods_path, notice: 'Cuenta bancaria eliminada con exito.' }
      format.json { head :no_content }
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
end
