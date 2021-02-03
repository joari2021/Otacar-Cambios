class ConfigLotericaDepositsController < ApplicationController
  before_action :set_config_loterica_deposit, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!

  # GET /config_loterica_deposits
  # GET /config_loterica_deposits.json
  def index

    users = User.all
    users.each do |user|
      if user.is_admin?
        @user_admin = user
        break;
      end
    end

    day_actual = Time.now.utc.in_time_zone("Brasilia").strftime("%Y-%m-%d")
    parsed_date = Date.parse(day_actual)

    deposit_for_loterica = Transaction.where(metodo: "Deposito Por Loterica", created_at: parsed_date.midnight..parsed_date.end_of_day)
    
    count = deposit_for_loterica.count
    bancos_caixa = @user_admin.bank_brasils.where(bank:"Caixa",view:"true",status:"activo",deposit_for_loterica:true)
    if count === 0
        bancos_caixa.update_all(cupos_for_loterica:3)
    else
        deposit_for_loterica.where(status:"en proceso").each do |transaction|
          segundos = (Time.now.utc.in_time_zone("Brasilia") - transaction.created_at.in_time_zone("Brasilia")).to_i
          if segundos > 1200
              Transaction.find(transaction.id).update(status:"vencida")
              method = transaction.account_destinity_admin.split("-")
              cupos = BankBrasil.find(method[1].to_i).cupos_for_loterica
              cupos += 1
              BankBrasil.find(method[1].to_i).update(cupos_for_loterica: cupos)
          end
        end
    end

    config_loterica_deposits = ConfigLotericaDeposit.all
    
    if config_loterica_deposits.count > 0
        @config_loterica_deposit = config_loterica_deposits.find(2)

        def find_account_caixa(id)
          account_caixa =  BankBrasil.find(id)
          return "#{account_caixa.name.capitalize} #{account_caixa.last_name.capitalize}. Cta: #{account_caixa.number_account}" 
        end
    
        unless @config_loterica_deposit.prioridad_min_1.nil? || @config_loterica_deposit.prioridad_min_1 === 0
          @prioridad_min_1 = find_account_caixa(@config_loterica_deposit.prioridad_min_1)
          @cupos_restantes1 =  BankBrasil.find(@config_loterica_deposit.prioridad_min_1).cupos_for_loterica
        end
    
        unless @config_loterica_deposit.prioridad_min_2.nil? || @config_loterica_deposit.prioridad_min_2 === 0
          @prioridad_min_2 = find_account_caixa(@config_loterica_deposit.prioridad_min_2)
          @cupos_restantes2 =  BankBrasil.find(@config_loterica_deposit.prioridad_min_2).cupos_for_loterica
        end
    
        unless @config_loterica_deposit.prioridad_min_3.nil? || @config_loterica_deposit.prioridad_min_3 === 0
          @prioridad_min_3 = find_account_caixa(@config_loterica_deposit.prioridad_min_3)
          @cupos_restantes3 =  BankBrasil.find(@config_loterica_deposit.prioridad_min_3).cupos_for_loterica
        end
    
        unless @config_loterica_deposit.prioridad_max_1.nil? || @config_loterica_deposit.prioridad_max_1 === 0
          @prioridad_max_1 = find_account_caixa(@config_loterica_deposit.prioridad_max_1)
          @cupos_restantes4 =  BankBrasil.find(@config_loterica_deposit.prioridad_max_1).cupos_for_loterica
        end
    
        unless @config_loterica_deposit.prioridad_max_2.nil? || @config_loterica_deposit.prioridad_max_2 === 0
          @prioridad_max_2 = find_account_caixa(@config_loterica_deposit.prioridad_max_2)
          @cupos_restantes5 =  BankBrasil.find(@config_loterica_deposit.prioridad_max_2).cupos_for_loterica
        end
    
        unless @config_loterica_deposit.prioridad_max_3.nil? || @config_loterica_deposit.prioridad_max_3 === 0
          @prioridad_max_3 = find_account_caixa(@config_loterica_deposit.prioridad_max_3)
          @cupos_restantes6 =  BankBrasil.find(@config_loterica_deposit.prioridad_max_3).cupos_for_loterica
        end
    end

    
  end

  # GET /config_loterica_deposits/1
  # GET /config_loterica_deposits/1.json
  def show
  end

  # GET /config_loterica_deposits/new
  def new
    @config_loterica_deposit = ConfigLotericaDeposit.new
  end

  # GET /config_loterica_deposits/1/edit
  def edit
  end

  # POST /config_loterica_deposits
  # POST /config_loterica_deposits.json
  def create
    @config_loterica_deposit = ConfigLotericaDeposit.new(config_loterica_deposit_params)

    respond_to do |format|
      if @config_loterica_deposit.save
        BankBrasil.where(bank:"Caixa",status:"activo",view:true).update_all(deposit_for_loterica:false)

        if @config_loterica_deposit.prioridad_min_1.present? && @config_loterica_deposit.prioridad_min_1 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_min_1).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_min_2.present? && @config_loterica_deposit.prioridad_min_2 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_min_2).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_min_3.present? && @config_loterica_deposit.prioridad_min_3 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_min_3).update(deposit_for_loterica:true)
        end

        if @config_loterica_deposit.prioridad_max_1.present? && @config_loterica_deposit.prioridad_max_1 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_max_1).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_max_2.present? && @config_loterica_deposit.prioridad_max_2 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_max_2).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_max_3.present? && @config_loterica_deposit.prioridad_max_3 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_max_3).update(deposit_for_loterica:true)
        end

        format.html { redirect_to config_loterica_deposits_url notice: 'Configuracion editada con exito.' }
        format.json { render :show, status: :created, location: @config_loterica_deposit }
      else
        format.html { render :new }
        format.json { render json: @config_loterica_deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /config_loterica_deposits/1
  # PATCH/PUT /config_loterica_deposits/1.json
  def update
    respond_to do |format|
      if @config_loterica_deposit.update(config_loterica_deposit_params)
        BankBrasil.where(bank:"Caixa",status:"activo",view:true).update_all(deposit_for_loterica:false)

        if @config_loterica_deposit.prioridad_min_1.present? && @config_loterica_deposit.prioridad_min_1 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_min_1).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_min_2.present? && @config_loterica_deposit.prioridad_min_2 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_min_2).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_min_3.present? && @config_loterica_deposit.prioridad_min_3 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_min_3).update(deposit_for_loterica:true)
        end

        if @config_loterica_deposit.prioridad_max_1.present? && @config_loterica_deposit.prioridad_max_1 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_max_1).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_max_2.present? && @config_loterica_deposit.prioridad_max_2 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_max_2).update(deposit_for_loterica:true)
        end
        if @config_loterica_deposit.prioridad_max_3.present? && @config_loterica_deposit.prioridad_max_3 > 0
          BankBrasil.find(@config_loterica_deposit.prioridad_max_3).update(deposit_for_loterica:true)
        end

        format.html { redirect_to config_loterica_deposits_url, notice: 'Configuracion editada con exito.' }
      else
        format.html { render :edit }
        format.json { render json: @config_loterica_deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /config_loterica_deposits/1
  # DELETE /config_loterica_deposits/1.json
  def destroy
    @config_loterica_deposit.destroy
    respond_to do |format|
      format.html { redirect_to config_loterica_deposits_url, notice: 'Config loterica deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_loterica_deposit
      @config_loterica_deposit = ConfigLotericaDeposit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def config_loterica_deposit_params
      params.require(:config_loterica_deposit).permit(:prioridad_min_1, :prioridad_min_2, :prioridad_min_3, :prioridad_max_1, :prioridad_max_2, :prioridad_max_3)
    end
end
