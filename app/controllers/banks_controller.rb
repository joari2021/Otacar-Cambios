class BanksController < ApplicationController
  before_action :set_bank, only: [:destroy]
  #before_action :authenticate_admin!, only: [:edit, :update]

  # GET /banks
  # GET /banks.json
  def index
    @banks = Bank.all
  end

  # GET /banks/1
  # GET /banks/1.json
  #def show
  #end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  #def edit
  #end

  # POST /banks
  # POST /banks.json
  def create
    @banco = Bank.new(bank_params)
    @banco.verify_data_saved

    if @banco.banco != "" && @banco.type_account != ""
      if @banco.country.capitalize === current_user.country.capitalize 
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @banco.country != "Argentina" && @banco.country != "Chile" && @banco.country != "Ecuador" && @banco.country != "Panama" && @banco.country != "Peru" && @banco.country != "Venezuela" 
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @bank = current_user.banks.create(bank_params)
          respond_to do |format|
            if @bank.save
              format.html { redirect_to payment_methods_path, notice: 'Cuenta bancaria registrada con exito.' }
              format.json { render :show, status: :created, location: @bank }
            else
              format.html { render :new }
              format.json { render json: @bank.errors, status: :unprocessable_entity }
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

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  #def update
  #  respond_to do |format|
  #    if @bank.update(bank_params)
  #      format.html { redirect_to @bank, notice: 'Bank was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @bank }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @bank.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to payment_methods_path, notice: 'Cuenta bancaria eliminada con exito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:name, :last_name, :identidy, :country, :state, :banco, :number_account, :type_account, :cod_bank, :phone)
    end
end
