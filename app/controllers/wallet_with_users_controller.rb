class WalletWithUsersController < ApplicationController
  before_action :set_wallet_with_user, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]

  # GET /wallet_with_users
  # GET /wallet_with_users.json
  def index
    @wallet_with_users = WalletWithUser.all
  end

  # GET /wallet_with_users/1
  # GET /wallet_with_users/1.json
  def show
  end

  # GET /wallet_with_users/new
  def new
    @wallet_with_user = WalletWithUser.new
  end

  # GET /wallet_with_users/1/edit
  def edit
  end

  # POST /wallet_with_users
  # POST /wallet_with_users.json
  def create
    @method = WalletWithUser.new(wallet_with_user_params)
    @method.verify_data_saved

    if @method.wallet_name != ""
      unless @method.country.capitalize != current_user.country.capitalize || current_user.is_admin? 
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @method.country != "Brasil"
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @wallet_with_user = current_user.wallet_with_users.create(wallet_with_user_params)
          respond_to do |format|
            if @wallet_with_user.save
              format.html { redirect_to payment_methods_path, notice: 'Pago Digital guardado con exito.' }
              format.json { render :show, status: :created, location: @wallet_with_user }
            else
              format.html { render :new }
              format.json { render json: @wallet_with_user.errors, status: :unprocessable_entity }
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

  # PATCH/PUT /wallet_with_users/1
  # PATCH/PUT /wallet_with_users/1.json
  def update
    respond_to do |format|
      if @wallet_with_user.update(wallet_with_user_edit_params)
        if @wallet_with_user.status === "activo"
          mensaje = 'Pago Digital activado con exito.'
        else
          mensaje = 'Pago Digital inactivado con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje }
        format.json { render :show, status: :ok, location: @wallet_with_user }
      else
        format.html { render :edit }
        format.json { render json: @wallet_with_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallet_with_users/1
  # DELETE /wallet_with_users/1.json
  def destroy
    if @wallet_with_user.permit_delete === "denied"
      respond_to do |format|
        format.html { redirect_to payment_methods_path, alert: 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción y debe terminar las transacciones que tenga en proceso para poder eliminarla.' }
        format.json { head :no_content }
      end
    elsif @wallet_with_user.permit_delete === "only_user"
      @wallet_with_user.update(view:"false")
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Monedero Digital eliminado con exito.' }
        format.json { head :no_content }
      end
    else
      @wallet_with_user.destroy
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Monedero Digital eliminado con exito.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet_with_user
      @wallet_with_user = WalletWithUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_with_user_params
      params.require(:wallet_with_user).permit(:country, :name, :last_name, :usuario, :wallet_name)
    end

    def wallet_with_user_edit_params
      params.require(:wallet_with_user).permit(:status)
    end
end
