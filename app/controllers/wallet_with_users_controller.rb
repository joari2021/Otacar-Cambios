class WalletWithUsersController < ApplicationController
  before_action :set_wallet_with_user, only: [:destroy]

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
    @wallet_with_user = current_user.wallet_with_users.create(wallet_with_user_params)

    if @wallet_with_user.country.capitalize === current_user.country.capitalize 
      respond_to do |format|
        format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
      end
    else 
      if @wallet_with_user.country != "Brasil"
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else
        @wallet_with_user.verify_data_saved
        respond_to do |format|
          if @wallet_with_user.save
            format.html { redirect_to payment_methods_path, notice: 'El monedero digital fue guardado con exito.' }
            format.json { render :show, status: :created, location: @wallet_with_user }
          else
            format.html { render :new }
            format.json { render json: @wallet_with_user.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /wallet_with_users/1
  # PATCH/PUT /wallet_with_users/1.json
  def update
    respond_to do |format|
      if @wallet_with_user.update(wallet_with_user_params)
        format.html { redirect_to @wallet_with_user, notice: 'Wallet with user was successfully updated.' }
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
    @wallet_with_user.destroy
    respond_to do |format|
      format.html { redirect_to wallet_with_users_url, notice: 'El monedero digital fue eliminado con exito.' }
      format.json { head :no_content }
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
end
