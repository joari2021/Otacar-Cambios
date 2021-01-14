class WalletsController < ApplicationController
  before_action :set_wallet, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]
  before_action :authenticate_user!
  # GET /wallets
  # GET /wallets.json 
  def index
    @wallets = Wallet.all
  end

  # GET /wallets/1
  # GET /wallets/1.json
  def show
  end


  # GET /wallets/new
  def new
    @wallet = Wallet.new
  end

  # GET /wallets/1/edit
  def edit
  end

  # POST /wallets
  # POST /wallets.json
  def create
    @method = Wallet.new(wallet_params)
    @method.verify_data_saved

    if @method.wallet_name != ""
      unless @method.country.capitalize != current_user.country.capitalize || current_user.is_admin? 
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @method.country != "Brasil" && @method.country != "USA"
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @wallet = current_user.wallets.create(wallet_params)
          respond_to do |format|
            if @wallet.save
              format.html { redirect_to payment_methods_path, notice: 'Monedero Digital guardado con exito.' }
              format.json { render :show, status: :created, location: @wallet }
            else
              format.html { render :new }
              format.json { render json: @wallet.errors, status: :unprocessable_entity }
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

  # PATCH/PUT /wallets/1
  # PATCH/PUT /wallets/1.json

  def update
    respond_to do |format|
      if @wallet.update(wallet_edit_params)
        if @wallet.status === "activo"
          mensaje = 'Monedero Digital activado con exito.'
        else
          mensaje = 'Monedero Digital inactivado con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1
  # DELETE /wallets/1.json
  def destroy
    if @wallet.permit_delete === "denied"
      respond_to do |format|
        format.html { redirect_to payment_methods_path, alert: 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción y debe terminar las transacciones que tenga en proceso para poder eliminarla.' }
        format.json { head :no_content }
      end
    elsif @wallet.permit_delete === "only_user"
      @wallet.update(view:"false")
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Monedero Digital eliminado con exito.' }
        format.json { head :no_content }
      end
    else
      @wallet.destroy
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Monedero Digital eliminado con exito.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:name, :last_name, :wallet_name, :email, :country)
    end

    def wallet_edit_params
      params.require(:wallet).permit(:status)
    end
end
