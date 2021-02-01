class WalletsController < ApplicationController
  before_action :set_wallet, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]
  before_action :authenticate_user!
  before_action :authenticate_normal_user!
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
    if @wallet.user.id === current_user.id
      if current_user.is_admin?
        
        transactions = Transaction.where(account_destinity_admin: "wallets-#{@wallet.id}")
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
            if account === "wallets-#{@wallet.id}"
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
              if account === "wallets-#{@wallet.id}"
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
        @wallet.update(view:"false")
        respond_to do |format|
          format.html { redirect_to payment_methods_path, notice: 'Cuenta eliminada con exito.' }
          format.json { head :no_content }
        end
      elsif permit_delete === "permit"
        @wallet.destroy
        respond_to do |format|
          format.html { redirect_to payment_methods_path, notice: 'Cuenta eliminada con exito.' }
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
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:bank, :name, :second_name, :last_name, :wallet_name, :type_identificador, :identificador, :country)
    end

    def wallet_edit_params
      params.require(:wallet).permit(:status)
    end
end
