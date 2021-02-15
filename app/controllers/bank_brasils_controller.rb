class BankBrasilsController < ApplicationController
  before_action :set_bank_brasil, only: [:edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:edit, :update]
  before_action :authenticate_user!
  before_action :authenticate_normal_user!

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
    @banco = BankBrasil.new(bank_brasil_params)
    @banco.verify_data_saved

    if @banco.bank != ""
      unless @banco.country.capitalize != current_user.country.capitalize || current_user.is_admin? 
         
        respond_to do |format|
          format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
        end
      else    
        if @banco.country != "Brasil" 
          respond_to do |format|
            format.html { redirect_to set_method_path, notice: 'Pais Invalido.' }
          end
        else
          @bank_brasil = current_user.bank_brasils.create(bank_brasil_params)
          @bank_brasil.modify_document
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
    else
      respond_to do |format|
        format.html { redirect_to set_method_path, notice: 'Ha seleccionado opciones invalidas.' }
      end
    end  
  end

  # PATCH/PUT /bank_brasils/1
  # PATCH/PUT /bank_brasils/1.json
  def update
    respond_to do |format|
      if @bank_brasil.update(bank_brasil_edit_params)
        if @bank_brasil.status === "activo"
          mensaje = 'Cuenta Bancaria activada con exito.'
        else
          mensaje = 'Cuenta Bancaria inactivada con exito.'
        end
        format.html { redirect_to payment_methods_path, notice: mensaje}
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
    if @bank_brasil.user.id === current_user.id
      if current_user.is_admin?

        if @bank_brasil.bank === "Caixa"
          
          config_deposit_Loterica = ConfigLotericaDeposit.find(2)

          case @bank_brasil.id
          when config_deposit_Loterica.prioridad_min_1
            deposit_for_loterica = true
          when config_deposit_Loterica.prioridad_min_2
            deposit_for_loterica = true
          when config_deposit_Loterica.prioridad_min_3
            deposit_for_loterica = true
          when config_deposit_Loterica.prioridad_max_1
            deposit_for_loterica = true
          when config_deposit_Loterica.prioridad_max_2
            deposit_for_loterica = true
          when config_deposit_Loterica.prioridad_max_3
            deposit_for_loterica = true
          else
            deposit_for_loterica = false
          end
          
        end

        if @bank_brasil.bank === "Caixa" && deposit_for_loterica
          permit_delete = "denied"
        else
          transactions = Transaction.where(account_destinity_admin: "bank_brasils-#{@bank_brasil.id}")
          if transactions.count > 0
            permit_delete = "only_user"
          else
            permit_delete = "permit"
          end
        end
  
      else
        transactions = current_user.transactions.where("status LIKE ? OR status LIKE ? OR status LIKE ?", "en proceso", "envio en proceso", "por confirmar")
        permit_delete = ""
        transactions.each do |transaction|
          array_account = transaction.account_destinity_usuario.split(",")
          array_account.each do |account|
            if account === "bank_brasils-#{@bank_brasil.id}"
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
              if account === "bank_brasils-#{@bank_brasil.id}"
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
        if current_user.is_admin?
          info = "Esta cuenta esta registrada en la configuración de los depositos por Loterica. Primero debe removerla de la configuración para poder eliminarla."
        else
          info = 'Esta cuenta no puede ser eliminada debido a que esta siendo usada en una transacción en proceso.'
        end
        respond_to do |format|
          format.html { redirect_to payment_methods_path, alert: info }
          format.json { head :no_content }
        end
      elsif permit_delete === "only_user"
        @bank_brasil.update(view:"false")
        respond_to do |format|
          format.html { redirect_to payment_methods_path, notice: 'Cuenta Bancaria eliminada con exito.' }
          format.json { head :no_content }
        end
      elsif permit_delete === "permit"
        @bank_brasil.destroy
        respond_to do |format|
          format.html { redirect_to payment_methods_path, notice: 'Cuenta Bancaria eliminada con exito.' }
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
    def set_bank_brasil
      @bank_brasil = BankBrasil.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_brasil_params
      params.require(:bank_brasil).permit(:name, :second_name, :last_name, :country, :type_document, :document, :bank, :number_agency, :number_account, :type_account, :operation)
    end

    def bank_brasil_edit_params
      params.require(:bank_brasil).permit(:status)
    end
end
