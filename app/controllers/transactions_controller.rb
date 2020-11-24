class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:pending]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
    @banks = Bank.all
  end

  def status

    current_user.transactions.each do |transaction|
      if transaction.status === "en proceso"
        segundos = (Time.now.utc - transaction.created_at).to_i
        if segundos < 1200
          @transaction_pendiente = transaction
          segundos = 1200 - segundos
          @minutos = segundos / 60
          @segundos = segundos - (@minutos * 60)
          break
        end
      end
    end
    
    rates = Rate.all
    rates.each do |rate|
      if rate.country === current_user.country
        @rate = rate
      end
    end

    users = User.all
    users.each do |user|
      if user.is_admin?
        @user_admin = user
      end
    end
  end
  # GET /transactions/1
  # GET /transactions/1.json

  def pending
    @transactions = Transaction.all

    rates = Rate.all
  end

  def show
  end

  # GET /transactions/new
  def new
    current_user.transactions.each do |transaction|
      if transaction.status === "en proceso"
        segundos = (Time.now.utc - transaction.created_at).to_i
        if segundos < 1200
          @transaction_pendiente = transaction
          break
        end
      end
    end

    @transaction = Transaction.new

    users = User.all
    users.each do |user|
      if user.is_admin?
        @user_admin = user
      end
    end
    rates = Rate.all
    rates.each do |rate|
      if rate.country === current_user.country
        @rate = rate
      end
    end
  end

  # GET /transactions/1/edit
  def edit
    current_user.transactions.each do |transaction|
      if transaction.status === "en proceso"
        segundos = (Time.now.utc - transaction.created_at).to_i
        if segundos < 1200
          @transaction_pendiente = transaction
          segundos = 1200 - segundos
          @minutos = segundos / 60
          @segundos = segundos - (@minutos * 60)
          break
        end
      end
    end

    users = User.all
    users.each do |user|
      if user.is_admin?
        @user_admin = user
      end
    end

    rates = Rate.all
    rates.each do |rate|
      if rate.country === current_user.country
        @rate = rate
      end
    end

    unless @transaction_pendiente
      respond_to do |format|
        format.html { redirect_to status_transactions_path, alert: 'Su ultima transaccion creada ha vencido. Por favor cree una nueva.' }
      end
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    
    transaction_inicial = Transaction.new(transaction_params)

    rates = Rate.all
    rates.each do |rate|
      if rate.country === current_user.country
        @rate = rate
      end
    end
    monto_envio = transaction_inicial.monto_envio.gsub('.','')
    monto_envio.gsub!(',','.')
    monto_envio = monto_envio.to_f

    if monto_envio > 0
      case transaction_inicial.country_destinity
      
        when "Argentina"
          tasaMin = @rate.rate_argentina
          tasaOf = @rate.rate_argentina_min
          montoMin = @rate.monto_min_argentina
          barrera_1 = true
        when "Brasil"
          tasaMin = @rate.rate_brasil
          tasaOf = @rate.rate_brasil_min
          montoMin = @rate.monto_min_brasil
          barrera_1 = true
        when "Chile"
          tasaMin = @rate.rate_chile
          tasaOf = @rate.rate_chile_min
          montoMin = @rate.monto_min_chile
          barrera_1 = true
        when "Colombia"
          tasaMin = @rate.rate_colombia
          tasaOf = @rate.rate_colombia_min
          montoMin = @rate.monto_min_colombia
          barrera_1 = true
        when "Ecuador"
          tasaMin = @rate.rate_ecuador
          tasaOf = @rate.rate_ecuador_min
          montoMin = @rate.monto_min_ecuador
          barrera_1 = true
        when "España"
          tasaMin = @rate.rate_españa
          tasaOf = @rate.rate_españa_min
          montoMin = @rate.monto_min_españa
          barrera_1 = true
        when "Panama"
          tasaMin = @rate.rate_panama
          tasaOf = @rate.rate_panama_min
          montoMin = @rate.monto_min_panama
          barrera_1 = true
        when "Peru"
          tasaMin = @rate.rate_peru
          tasaOf = @rate.rate_peru_min
          montoMin = @rate.monto_min_peru
          barrera_1 = true
        when "USA"
          tasaMin = @rate.rate_usa
          tasaOf = @rate.rate_usa_min
          montoMin = @rate.monto_min_usa
          barrera_1 = true
        when "Venezuela"
          tasaMin = @rate.rate_venezuela
          tasaOf = @rate.rate_venezuela_min
          montoMin = @rate.monto_min_venezuela
          barrera_1 = true
        else
          barrera_1 = false
      end

      if barrera_1
        monto_oferta = @rate.monto_oferta.gsub('.','')
        monto_oferta.gsub!(',','.')
        monto_oferta = monto_oferta.to_f
  
        tasaMin.gsub!('.','')
        tasaMin.gsub!(',','.')
        tasaMin = tasaMin.to_f
  
        tasaOf.gsub!('.','')
        tasaOf.gsub!(',','.')
        tasaOf = tasaOf.to_f
        
        montoMin.gsub!('.','')
        montoMin.gsub!(',','.')
        montoMin = montoMin.to_f
  
        if monto_envio >= montoMin
          if monto_oferta > 0
            if monto_envio < monto_oferta
              tasa_definitiva = tasaMin
            else
              if tasaOf > 0
                tasa_definitiva = tasaOf
              else 
                tasa_definitiva = tasaMin
              end
            end  
          else
            tasa_definitiva = tasaMin
          end
          resultado = monto_envio * tasa_definitiva
          
          @transaction = current_user.transactions.create(transaction_params)
          @transaction.modify_monto_envio
          @transaction.monto_a_recibir = resultado
    
          respond_to do |format|
            if @transaction.save
              format.html { redirect_to status_transactions_path, notice: "Transacción iniciada con exito. Tiene 20 minutos para hacer el pago" }
              format.json { render :show, status: :created, location: @transaction }
            else
              format.html { render :new }
              format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
          end
        else
          respond_to do |format|
            format.html { redirect_to new_transaction_path, alert: 'Monto inferior al monto minimo.' }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_transaction_path, alert: 'Pais Invalido.' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_transaction_path, alert: 'Monto Invalido.' }
      end
    end

  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    unless  current_user.is_admin?
      @transaction.update(transaction_params_user_edit)
      @transaction.status = "por confirmar"
    
      respond_to do |format|
        if @transaction.update(transaction_params_user_edit)
          format.html { redirect_to status_transactions_path, notice: 'Su pago fue enviado con exito, por favor espere que sea confirmado.' }
        else
          format.html { render :edit }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @transaction.update(transaction_params)
          format.html { redirect_to @transaction, notice: 'Transaccion cancelada con exito.' }
          format.json { render :show, status: :ok, location: @transaction }
        else
          format.html { render :edit }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to status_transactions_path, notice: 'Transacción eliminada con exito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def transaction_params
      params.require(:transaction).permit(:country_destinity, :account_destinity_usuario, :account_destinity_admin, :metodo, :monto_envio, :monto_a_recibir)
    end

    def transaction_params_user_edit
      params.require(:transaction).permit(:status, :comprobante)
    end

end
