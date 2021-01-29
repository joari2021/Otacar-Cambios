class BanksController < ApplicationController
  before_action :set_bank, only: [:destroy, :edit, :update]
  before_action :authenticate_admin!, only: [:edit, :update]
  before_action :authenticate_user!

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
  def edit
  end

  # POST /banks
  # POST /banks.json
  def create
    @banco = Bank.new(bank_params)
    @banco.verify_data_saved

    if @banco.banco != "" && @banco.type_account != ""
      unless @banco.country.capitalize != current_user.country.capitalize || current_user.is_admin? 
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @banco.country != "Argentina" && @banco.country != "Chile" && @banco.country != "Colombia" && @banco.country != "Ecuador" && @banco.country != "España" && @banco.country != "Panama" && @banco.country != "Peru" && @banco.country != "Venezuela" 
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @bank = current_user.banks.create(bank_params)
          respond_to do |format|
            if @bank.save
              info_adicional = ""
              if @bank.country === "Venezuela"
                if @bank.number_phone.length === 11
                  if @bank.banco === "Banco De Venezuela"
                    banco = "0102"
                  elsif @bank.banco === "Banco Banesco"
                    banco = "0134"
                  elsif @bank.banco === "B.O.D"
                    banco = "0116"
                  elsif @bank.banco === "Banco Mercantil"
                    banco = "0105"
                  else
                    banco = @bank.banco
                  end
                  @mobile_payment = current_user.mobile_payments.create(country:@bank.country, bank:banco, number_phone:@bank.number_phone, document: @bank.type_document + "-" + @bank.identidy, name: @bank.name, second_name: @bank.second_name, last_name: @bank.last_name)
                  info_adicional = "Pago Móvil registrado con exito"
                else
                  info_adicional = "El pago móvil no pudo ser registrado porque el número es invalido"
                end
              end
              format.html { redirect_to payment_methods_path, notice: 'Cuenta bancaria registrada con exito. ' + info_adicional}
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
  def update
    respond_to do |format|
      if @bank.update(bank_params2)
        if @bank.status === "activo"
          mensaje = 'Cuenta Bancaria activada con exito.'
        else
          mensaje = 'Cuenta Bancaria inactivada con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje }
        format.json { render :show, status: :ok, location: @bank }
      else
        format.html { render :edit }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    #transactions = Transaction.where("account_destinity_usuario LIKE ?", "%banks-#{@bank.id}%")
    if @bank.permit_delete === "denied"
      respond_to do |format|
        format.html { redirect_to payment_methods_path, alert: 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción y debe terminar las transacciones que tenga en proceso para poder eliminarla.' }
        format.json { head :no_content }
      end
    elsif @bank.permit_delete === "only_user"
      @bank.update(view:"false")
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Cuenta Bancaria eliminada con exito.' }
        format.json { head :no_content }
      end
    else
      @bank.destroy
      respond_to do |format|
        format.html { redirect_to payment_methods_path, notice: 'Cuenta Bancaria eliminada con exito.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:name, :second_name, :last_name, :identidy, :country, :banco, :number_account, :type_account, :type_document, :number_phone)
    end

    def bank_params2
      params.require(:bank).permit(:status)
    end
end
