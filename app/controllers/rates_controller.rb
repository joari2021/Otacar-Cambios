class RatesController < ApplicationController
  before_action :set_rate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /rates
  # GET /rates.json
  def index
    @rates = Rate.all
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = Rate.new(rate_params)

    respond_to do |format|
      if @rate.save
        format.html { redirect_to rates_path, notice: 'Registro de tasas creado con exito.' }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to rates_path, notice: 'Tasas guardadas con exito.' }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: 'Rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(:country, :moneda, :monto_oferta, :rate_brasil, :rate_brasil_min, :rate_chile, :rate_chile_min, :rate_ecuador, :rate_ecuador_min, :rate_españa, :rate_españa_min, :rate_panama, :rate_panama_min, :rate_peru, :rate_peru_min, :rate_portugal, :rate_portugal_min, :rate_usa, :rate_usa_min, :rate_venezuela, :rate_venezuela_min) 
    end
end
