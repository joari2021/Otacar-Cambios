class AvalaibleBanksController < ApplicationController
  before_action :set_avalaible_bank, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_admin!

  # GET /avalaible_banks
  # GET /avalaible_banks.json
  def index
    @avalaible_banks = AvalaibleBank.all
  end

  # GET /avalaible_banks/1
  # GET /avalaible_banks/1.json
  def show
  end

  # GET /avalaible_banks/new
  def new
    @avalaible_bank = AvalaibleBank.new
  end

  # GET /avalaible_banks/1/edit
  def edit
  end

  # POST /avalaible_banks
  # POST /avalaible_banks.json
  def create
    @avalaible_bank = AvalaibleBank.new(avalaible_bank_params)

    respond_to do |format|
      if @avalaible_bank.save
        format.html { redirect_to avalaible_banks_url, notice: 'Banco activado.' }
        format.json { render :show, status: :created, location: @avalaible_bank }
      else
        format.html { render :new }
        format.json { render json: @avalaible_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avalaible_banks/1
  # PATCH/PUT /avalaible_banks/1.json
  def update
    respond_to do |format|
      if @avalaible_bank.update(avalaible_bank_params)
        format.html { redirect_to @avalaible_bank, notice: 'actualizado.' }
        format.json { render :show, status: :ok, location: @avalaible_bank }
      else
        format.html { render :edit }
        format.json { render json: @avalaible_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avalaible_banks/1
  # DELETE /avalaible_banks/1.json
  def destroy
    @avalaible_bank.destroy
    respond_to do |format|
      format.html { redirect_to avalaible_banks_url, notice: 'Banco inactivado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avalaible_bank
      @avalaible_bank = AvalaibleBank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def avalaible_bank_params
      params.require(:avalaible_bank).permit(:bank)
    end
end
