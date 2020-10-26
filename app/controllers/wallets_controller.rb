class WalletsController < ApplicationController
  before_action :set_wallet, only: [:destroy]

  # GET /wallets
  # GET /wallets.json
=begin  
  def index
    @wallets = Wallet.all
  end

  # GET /wallets/1
  # GET /wallets/1.json
  def show
  end
=end

  # GET /wallets/new
  def new
    @wallet = Wallet.new
  end

  # GET /wallets/1/edit
  #def edit
  #end

  # POST /wallets
  # POST /wallets.json
  def create
    @wallet = Wallet.new(wallet_params)
    
    if @wallet.country != "Brasil"
      respond_to do |format|
        format.html { redirect_to set_method_url, notice: 'Pais Invalido.' }
      end
    else
      respond_to do |format|
        if @wallet.save
          format.html { redirect_to payment_methods_url, notice: 'El monedero digital ha sido guardado con exito.' }
          format.json { render :show, status: :created, location: @wallet }
        else
          format.html { render :new }
          format.json { render json: @wallet.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /wallets/1
  # PATCH/PUT /wallets/1.json
=begin
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to @wallet, notice: 'Wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end
=end
  # DELETE /wallets/1
  # DELETE /wallets/1.json
  def destroy
    @wallet.destroy
    respond_to do |format|
      format.html { redirect_to payment_methods_url, notice: 'El monedero digital fue eliminado con exito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:name, :last_name, :email, :country)
    end
end
