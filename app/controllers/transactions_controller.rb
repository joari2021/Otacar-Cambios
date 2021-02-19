class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authenticate_normal_user!, except: [:pending]
  before_action :authenticate_admin!, only: [:pending]
  # GET /transactions
  # GET /transactions.json
  def index
    limit_items_for_page = 20
    
    if current_user.is_admin?
      @transactions = Transaction.paginate(page: params[:page],per_page:limit_items_for_page)
                                .where(status:"realizada")
                                .order("created_at DESC")
    else
      @transactions = current_user.transactions.paginate(page: params[:page],per_page:limit_items_for_page)
                                               .where(status:"realizada")
                                               .order("created_at DESC")
    end

    count_transactions = @transactions.count
    if count_transactions % limit_items_for_page != 0
      @paginas = count_transactions / limit_items_for_page
      transactions_paginadas = @paginas.to_i * limit_items_for_page
      #transactions_not_paginate = count_transactions - transactions_paginadas
      array_transactions_not_paginate = []
      var = 1
      transactions_all = Transaction.where(status:"realizada").order("created_at DESC")
      transactions_all.each do |transaction|
        if var > transactions_paginadas
          array_transactions_not_paginate.push(transaction.id)
        end
        var = var + 1
      end
      
      @transactions_not_paginate = transactions_all.where(id: array_transactions_not_paginate) 
    end
    
  end


  def status

    ############# IDENTIFICANDO TRANSACCIONES PENDIENTES ###############
    current_user.transactions.each do |transaction|
      if transaction.status === "en proceso"
        segundos = (Time.now.utc - transaction.created_at).to_i
        if segundos <= 1200
          @transaction_pendiente = transaction
          segundos = 1200 - segundos
          @minutos = segundos / 60
          @segundos = segundos - (@minutos * 60)
        else
          Transaction.find(transaction.id).update(status:"vencida")
          method = transaction.account_destinity_admin.split("-")
          cupos = BankBrasil.find(method[1].to_i).cupos_for_loterica
          cupos += 1
          BankBrasil.find(method[1].to_i).update(cupos_for_loterica: cupos)
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

    #COMPROBAR CUPOS DE LOTERICA Y RESETEAR
    if current_user.country === "Brasil"
      day_actual = Time.now.utc.in_time_zone("Brasilia").strftime("%Y-%m-%d")
      parsed_date = Date.parse(day_actual)

      deposit_for_loterica = Transaction.where(metodo: "Deposito Por Loterica", created_at: parsed_date.midnight..parsed_date.end_of_day)
      
      count = deposit_for_loterica.count
      bancos_caixa = @user_admin.bank_brasils.where(bank:"Caixa",view:"true",status:"activo",deposit_for_loterica:true)
      if count === 0
          bancos_caixa.update_all(cupos_for_loterica:3)
      else  #REDEFINIR EL ESTADO DE LAS TRANSACCIONES EN PROCESO SI ESTAN VENCIDAS
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
    end
    
  end
  # GET /transactions/1
  # GET /transactions/1.json

  def pending
    @transactions = Transaction.order("created_at ASC")
    
    rates = Rate.all
  end

  def show

    unless current_user.is_admin?
      if @transaction.user.id != current_user.id
        respond_to do |format|
          format.html { redirect_to user_root_path }
        end
      end
    else
      @users = User.all
    end
    
    @user_admin = User.find_by(permission_level:3)
      
  end

  # GET /transactions/new
  def new
    if current_user.status_referencia === "confirmada"
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
          break;
        end
      end

      rates = Rate.all
      rates.each do |rate|
        if rate.country === current_user.country
          @rate = rate
        end
      end
    
      #COMPROBAR CUPOS DE LOTERICA Y RESETEAR
      if current_user.country === "Brasil"
        day_actual = Time.now.utc.in_time_zone("Brasilia").strftime("%Y-%m-%d")
        parsed_date = Date.parse(day_actual)

        deposit_for_loterica = Transaction.where(metodo: "Deposito Por Loterica", created_at: parsed_date.midnight..parsed_date.end_of_day)
        
        count = deposit_for_loterica.count
        bancos_caixa = @user_admin.bank_brasils.where(bank:"Caixa",view:"true",status:"activo",deposit_for_loterica:true)
        if count === 0
            bancos_caixa.update_all(cupos_for_loterica:3)
        else  #REDEFINIR EL ESTADO DE LAS TRANSACCIONES EN PROCESO SI ESTAN VENCIDAS
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

        @cupos_for_loterica = 0
        if bancos_caixa.present?
          bancos_caixa.each do |bank|
            @cupos_for_loterica += bank.cupos_for_loterica
          end
        end
      end
      
      @avalaible_banks = AvalaibleBank.all
    end
  end

  # GET /transactions/1/edit
  def edit
    unless current_user.is_admin?
      if @transaction.user.id != current_user.id
        respond_to do |format|
          format.html { redirect_to user_root_path }
        end
      end
    end

    current_user.transactions.each do |transaction|
      if transaction.status === "en proceso"
        segundos = (Time.now.utc - transaction.created_at).to_i
        if segundos < 1200000
          @transaction_pendiente = transaction
          segundos = 1200000 - segundos
          @minutos = segundos / 60
          @segundos = segundos - (@minutos * 60)
          break
        end
      end
    end

    users = User.all
    if current_user.is_admin?
      @users = users
    end

    users.each do |user|
      if user.is_admin?
        @user_admin = user
      end
    end

    @rate = Rate.find_by(country: @transaction.user.country)
    
    unless current_user.is_admin?
      unless @transaction_pendiente
        respond_to do |format|
          format.html { redirect_to status_transactions_path, alert: 'Su ultima transaccion creada ha vencido. Por favor cree una nueva.' }
        end
      end
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    
    @rate = Rate.find_by(country: current_user.country)
    if @rate.status_envio
      if current_user.status_referencia === "confirmada"
        unless @transaction_pendiente
          transaction_inicial = Transaction.new(transaction_params)
  
          monto_envio = transaction_inicial.monto_envio.to_f
          
          if monto_envio > 0
            @tasaMin = ""
            @tasaOf = ""
            @montoMin = ""
            @barrera_1 = false
            obtener_tasas(transaction_inicial.country_destinity)
            
            if @barrera_1
              monto_oferta = formatear_tasas()
              
              if monto_envio >= @montoMin
                if monto_oferta > 0
                  if monto_envio < monto_oferta
                    tasa_definitiva = @tasaMin
                  else
                    if @tasaOf > 0
                      tasa_definitiva = @tasaOf
                    else 
                      tasa_definitiva = @tasaMin
                    end
                  end  
                else
                  tasa_definitiva = @tasaMin
                end
                
                resultado = monto_envio * tasa_definitiva
                
                @transaction = current_user.transactions.create(transaction_params)
                
                @transaction.verify_methods
       
                methods_usuario = @transaction.account_destinity_usuario.split(",")
                if methods_usuario.length === 1
                  method_usuario = @transaction.account_destinity_usuario.split("-")
                  if method_usuario[0] === "mobile_payments"
                    bancos = ["0102", "0105", "0134", "0116"]
                    bank_pago = MobilePayment.find(method_usuario[1].to_i).bank
                      if bancos.include?(bank_pago)
                        comision = resultado - (resultado / 1.003)
                        resultado -= comision
                      end
                  end
                end
  
                @transaction.monto_envio = monto_envio
                @transaction.monto_a_recibir = resultado
                
                method_admin = @transaction.account_destinity_admin.split("-")
  
                if method_admin[0] === "caixa"
                    if @transaction.metodo === "Deposito Por Loterica"
                        day_actual = Time.now.utc.in_time_zone("Brasilia").strftime("%Y-%m-%d")
                        parsed_date = Date.parse(day_actual)
  
                        deposit_for_loterica = Transaction.where(metodo: "Deposito Por Loterica", created_at: parsed_date.midnight..parsed_date.end_of_day)
  
                        
                        @user_admin = User.find_by(permission_level:3)
                        count = deposit_for_loterica.count
                        
                        bancos_caixa = @user_admin.bank_brasils.where(bank:"Caixa",view:"true",status:"activo",deposit_for_loterica:true)
                        if count === 0
                            bancos_caixa.update_all(cupos_for_loterica:3)
                        else
                            deposit_for_loterica.where(status:"en proceso").each do |transaction|
                                segundos = (Time.now.utc.in_time_zone("Brasilia") - transaction.created_at.in_time_zone("Brasilia")).to_i
                                if segundos > 1200
                                    method = transaction.account_destinity_admin.split("-")
                                    cupos = BankBrasil.find(method[1].to_i).cupos_for_loterica
                                    cupos += 1
                                    BankBrasil.find(method[1].to_i).update(cupos_for_loterica: cupos)
                                end
                            end
                        end
                        
                        cupos_for_loterica = 0
                        bancos_caixa.each do |bank|
                          cupos_for_loterica += bank.cupos_for_loterica
                        end
                        
                        config_deposit_loterica = ConfigLotericaDeposit.all
                        find_account = false
                        if cupos_for_loterica > 0
                            if monto_envio <= 100  #PARA MONTOS MENORES A 100R$
                                
                                if config_deposit_loterica.count > 0
                                    config_deposit_loterica = ConfigLotericaDeposit.find(2)
                                    
                                    if config_deposit_loterica.prioridad_min_1 > 0
                                        account_caixa = BankBrasil.find(config_deposit_loterica.prioridad_min_1)
  
                                        if account_caixa.cupos_for_loterica > 0
                                            @transaction.account_destinity_admin = "bank_brasils-#{account_caixa.id}"
                                            find_account = true
                                        end
                                    end
  
                                    unless find_account
                                      if config_deposit_loterica.prioridad_min_2 > 0
                                          account_caixa = BankBrasil.find(config_deposit_loterica.prioridad_min_2)
  
                                          if account_caixa.cupos_for_loterica > 0
                                              @transaction.account_destinity_admin = "bank_brasils-#{account_caixa.id}"
                                              find_account = true
                                          end
                                      end
                                    end
  
                                    unless find_account
                                      if config_deposit_loterica.prioridad_min_3 > 0
                                          account_caixa = BankBrasil.find(config_deposit_loterica.prioridad_min_3)
  
                                          if account_caixa.cupos_for_loterica > 0
                                              @transaction.account_destinity_admin = "bank_brasils-#{account_caixa.id}"
                                              find_account = true
                                          end
                                      end
                                    end
                                end       
                            else    #PARA MONTOS MAYORES A 100R$
                                if config_deposit_loterica.count > 0
                                    config_deposit_loterica = ConfigLotericaDeposit.find(2)
                                    
                                    if config_deposit_loterica.prioridad_max_1 > 0
                                        account_caixa = BankBrasil.find(config_deposit_loterica.prioridad_max_1)
  
                                        if account_caixa.cupos_for_loterica > 0
                                            @transaction.account_destinity_admin = "bank_brasils-#{account_caixa.id}"
                                            find_account = true
                                        end
                                    end
  
                                    unless find_account
                                        if config_deposit_loterica.prioridad_max_2 > 0
                                            account_caixa = BankBrasil.find(config_deposit_loterica.prioridad_max_2)
  
                                            if account_caixa.cupos_for_loterica > 0
                                                @transaction.account_destinity_admin = "bank_brasils-#{account_caixa.id}"
                                                find_account = true
                                            end
                                        end
                                    end
  
                                    unless find_account
                                        if config_deposit_loterica.prioridad_max_3 > 0
                                            account_caixa = BankBrasil.find(config_deposit_loterica.prioridad_max_3)
  
                                            if account_caixa.cupos_for_loterica > 0
                                                @transaction.account_destinity_admin = "bank_brasils-#{account_caixa.id}"
                                                find_account = true
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            respond_to do |format|
                                format.html { redirect_to new_transaction_path, alert: 'Disculpanos. El ultimo cupo se agoto hace pocos segundos.' }
                            end
                        end
                    else 
                      @transaction.account_destinity_admin = "bank_brasils-#{method_admin[1]}"
                    end
                end
  
                #ENLAZAR LOS METODOS DE PAGO A LA TRANSACCION
                
                @transaction.num_id = 16.times.map { [*'0'..'9', *'A'..'Z'].sample }.join
                respond_to do |format|
                    if @transaction.save

                        #actualizar cupos de la cuenta caixa utilizada si la forma de pago fue deposito por loterica
                        
                        if @transaction.metodo === "Deposito Por Loterica"
                            method_admin = @transaction.account_destinity_admin.split("-")
                            cupos_actuales = BankBrasil.find(method_admin[1].to_i).cupos_for_loterica
                            cupos_actuales -= 1
                            BankBrasil.find(method_admin[1].to_i).update(cupos_for_loterica: cupos_actuales)
                        end
                        
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
  
        else
          respond_to do |format|
            format.html { redirect_to new_transaction_path, alert: 'Debe completar el pago pendiente por realizar para iniciar otra transacción.' }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_transaction_path, alert: 'Lo sentimos, aun no puedes enviar dinero.' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_transaction_path, alert: 'Envios no disponibles.' }
      end
    end
    
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    unless current_user.is_admin?
      
      if @transaction.user.id != current_user.id
        respond_to do |format|
          format.html { redirect_to user_root_path }
        end
      else
       
        validate_monto_total = true
        
        #MEJORAR EL CODIGO PARA VERIFICAR QUE LOS SUB MONTOS CONTENGAN CIFRAS QUE SEAN CORRECTAS Y NO INCLUYAN CARACTERES NO VALIDOS   ojooooooooooooooooooooooooooooooooooooo
        if @transaction.country_destinity === "Venezuela"
          parametros = transaction_params_user_edit
          methods_array = @transaction.account_destinity_usuario.split(",")
          monto_work = ""

          if methods_array.count === 2
            monto_1 = parametros["sub_monto_a_recibir_1"].gsub('.','')
            monto_1.gsub!(',','.')
            monto_1 = monto_1.to_f

            monto_2 = parametros["sub_monto_a_recibir_2"].gsub('.','')
            monto_2.gsub!(',','.')
            monto_2 = monto_2.to_f

            monto_envio_total = @transaction.monto_envio - monto_1 - monto_2
            monto_recibir_total = @transaction.monto_a_recibir - monto_1 - monto_2

            if monto_envio_total != 0
              if monto_recibir_total != 0
                validate_monto_total = false
              else
                monto_work = "recibir"
              end
            else
              monto_work = "envio"
            end

          elsif methods_array.count === 3
            monto_1 = parametros["sub_monto_a_recibir_1"].gsub('.','')
            monto_1.gsub!(',','.')
            monto_1 = monto_1.to_f

            monto_2 = parametros["sub_monto_a_recibir_2"].gsub('.','')
            monto_2.gsub!(',','.')
            monto_2 = monto_2.to_f

            monto_3 = parametros["sub_monto_a_recibir_3"].gsub('.','')
            monto_3.gsub!(',','.')
            monto_3 = monto_3.to_f

            monto_envio_total = @transaction.monto_envio - monto_1 - monto_2 - monto_3
            monto_recibir_total = @transaction.monto_a_recibir - monto_1 - monto_2 - monto_3

            if monto_envio_total != 0
              if monto_recibir_total != 0
                validate_monto_total = false
              else
                monto_work = "recibir"
              end
            else
              monto_work = "envio"
            end

          end  
        end

        if validate_monto_total

          respond_to do |format|
            
            if @transaction.update(transaction_params_user_edit)
              @transaction.update(status:"por confirmar")
              if @transaction.country_destinity === "Venezuela"
                if monto_work === "envio"
                  tasa = @transaction.monto_a_recibir / @transaction.monto_envio
                  if methods_array.count >= 2
                    monto_1 *= tasa
                    monto_2 *= tasa
                    @transaction.update(sub_monto_a_recibir_1: monto_1, sub_monto_a_recibir_2: monto_2)
                  end
                  if methods_array.count === 3
                    monto_3 *= tasa
                    @transaction.update(sub_monto_a_recibir_3: monto_3)
                  end
                else
                  if methods_array.count >= 2
                    @transaction.update(sub_monto_a_recibir_1: monto_1, sub_monto_a_recibir_2: monto_2)
                  end
                  if methods_array.count === 3
                    @transaction.update(sub_monto_a_recibir_3: monto_3)
                  end
                end
              end
              
              @transaction.send_email()
              format.html { redirect_to status_transactions_path, notice: 'Su pago fue enviado con exito, por favor espere que sea confirmado.' }
            else
              format.html { redirect_to edit_transaction_url(@transaction), alert: "El pago no se envio debido a un error en los datos ingresados, intentelo nuevamente." }
            end
          end
        else
          respond_to do |format| 
            format.html { redirect_to edit_transaction_url(@transaction), alert: "Los montos ingresados no son válidos." }
          end
        end
      end 
    else
      @rate = Rate.find_by(country: @transaction.user.country)
      if @transaction.status === "por confirmar"
        @transaction.update(transaction_params_admin_edit)

        if @transaction.motivo_rechazo === ""

          respond_to do |format|
            if @transaction.update(status:"envio en proceso")
              notification = @transaction.user.notifications.create(emisor:"Otacar Cambios",content:"La transacción ID: #{@transaction.num_id}, fue confirmada",asunto:"Transacción Confirmada")
              notification.save
              format.html { redirect_to pending_transactions_path, notice: 'Transaccion confirmada con exito.' }
              format.json { render :show, status: :ok, location: @transaction }
            else
              format.html { render :edit }
              format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
          end

        else
          respond_to do |format|
            if @transaction.update(status:"rechazada")
              notification = @transaction.user.notifications.create(emisor:"Otacar Cambios",content:"La transacción ID: #{@transaction.num_id}, fue rechazada",asunto:"Transacción rechazada")
              
              #RESTABLECER CUPO DE LOTERICA SI LA TRANSACCION ES RECHAZADA EL MISMO DIA
              if @transaction.metodo === "Deposito Por Loterica"
                day_actual = Time.now.utc.in_time_zone("Brasilia").strftime("%Y-%m-%d")
                date_transaction = @transaction.created_at.in_time_zone("Brasilia").strftime("%Y-%m-%d")
                method_admin = @transaction.account_destinity_admin.split("-")

                if day_actual === date_transaction
                  cupos = BankBrasil.find(method_admin[1].to_i).cupos_for_loterica
                  cupos += 1
                  BankBrasil.find(method_admin[1].to_i).update(cupos_for_loterica: cupos)
                end
                
              end

              format.html { redirect_to pending_transactions_path, notice: 'Transaccion rechazada con exito.' }
              format.json { render :show, status: :ok, location: @transaction }
            else
              format.html { render :edit }
              format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
          end
        end
      elsif @transaction.status === "envio en proceso"

        @transaction.update(transaction_params_admin_process)
        if @transaction.motivo_rechazo === ""

          respond_to do |format|
            if @transaction.update(status:"realizada")
              if @transaction.actualizacion_monto_envio
                methods_usuario = @transaction.account_destinity_usuario.split(",")
                
                @tasaMin = ""
                @tasaOf = ""
                @montoMin = ""
                obtener_tasas(@transaction.country_destinity)
                
                monto_oferta = formatear_tasas()
                @monto_envio = @transaction.monto_envio.to_f
                
                if monto_oferta > 0
                  if @monto_envio < monto_oferta
                    tasa_definitiva = @tasaMin
                  else
                    if @tasaOf > 0
                      tasa_definitiva = @tasaOf
                    else 
                      tasa_definitiva = @tasaMin
                    end
                  end  
                else
                  tasa_definitiva = @tasaMin
                end
                
                resultado = @monto_envio * tasa_definitiva
                @transaction.new_monto_a_recibir = resultado
                
                def actuality_sub_montos(monto,tasa_definitiva)
                  monto = monto.gsub('.','')
                  monto = monto.gsub(',','.')
                  monto = monto.to_f

                  tasa_anterior = @transaction.monto_a_recibir / @monto_envio
                  monto /= tasa_anterior
                  return resultado = monto * tasa_definitiva
                end

                if methods_usuario.count >= 2
                  
                  @transaction.new_sub_monto_a_recibir_1 = actuality_sub_montos(@transaction.sub_monto_a_recibir_1,tasa_definitiva)
                  @transaction.new_sub_monto_a_recibir_2 = actuality_sub_montos(@transaction.sub_monto_a_recibir_2,tasa_definitiva)
                end

                if methods_usuario.count === 3
                  @transaction.new_sub_monto_a_recibir_3 = actuality_sub_montos(@transaction.sub_monto_a_recibir_3,tasa_definitiva)
                end
              
                @transaction.save
              end
              notification = @transaction.user.notifications.create(emisor:"Otacar Cambios",content:"El envio fue realizado con exito. Transacción ID: #{@transaction.num_id}.",asunto:"Envio realizado")

              format.html { redirect_to pending_transactions_path, notice: 'Transaccion realizada con exito.' }
              format.json { render :show, status: :ok, location: @transaction }
            else
              format.html { render :edit }
              format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
          end

        else
          respond_to do |format|
            if @transaction.update(status:"presenta incidencia")
              notification = @transaction.user.notifications.create(emisor:"Otacar Cambios",content:"El envio no fue realizado porque presenta una incidencia. ID Transacción: #{@transaction.num_id}",asunto:"Envio no realizado")

              format.html { redirect_to pending_transactions_path, notice: 'Transaccion rechazada con exito.' }
              format.json { render :show, status: :ok, location: @transaction }
            else
              format.html { render :edit }
              format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    if @transaction.user.id === current_user.id
      if @transaction.status === "rechazada" || @transaction.status === "en proceso" || @transaction.status === "presenta incidencia" || @transaction.status === "vencida" 
        
        if @transaction.metodo === "Deposito Por Loterica"
          #RESTABLECER CUPO DE LOTERICA SI LA TRANSACCION CON ESTADO EN PROCESO ES ELIMINADA
          if @transaction.status === "en proceso"
            day_actual = Time.now.utc.in_time_zone("Brasilia").strftime("%Y-%m-%d")
            date_transaction = @transaction.created_at.in_time_zone("Brasilia").strftime("%Y-%m-%d")
            method_admin = @transaction.account_destinity_admin.split("-")

            if day_actual === date_transaction
              cupos = BankBrasil.find(method_admin[1].to_i).cupos_for_loterica
              cupos += 1
              BankBrasil.find(method_admin[1].to_i).update(cupos_for_loterica: cupos)
            end
            
          end
        end
        
        @transaction.destroy
        respond_to do |format|
          format.html { redirect_to status_transactions_path, notice: 'Transacción eliminada con exito.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to status_transactions_path, alert: 'Esta transacción no puede ser eliminada.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to status_transactions_path, alert: 'Acción invalida.' }
        format.json { head :no_content }
      end
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
      if @transaction.country_destinity === "Venezuela"
        params.require(:transaction).permit(:comprobante_pago_otacar, :sub_monto_a_recibir_1, :sub_monto_a_recibir_2, :sub_monto_a_recibir_3)
      else
        params.require(:transaction).permit(:comprobante_pago_otacar)
      end
      
    end

    def transaction_params_admin_edit
      params.require(:transaction).permit(:motivo_rechazo)
    end

    def transaction_params_admin_process
      params.require(:transaction).permit(:motivo_rechazo, :comprobante_pago_usuario, :comprobante_pago_usuario2, :comprobante_pago_usuario3, :actualizacion_monto_envio)
    end

    def obtener_tasas(country)
      case country
            
        when "Argentina"
          @tasaMin = @rate.rate_argentina
          @tasaOf = @rate.rate_argentina_min
          @montoMin = @rate.monto_min_argentina
          @barrera_1 = true
        when "Brasil"
          @tasaMin = @rate.rate_brasil
          @tasaOf = @rate.rate_brasil_min
          @montoMin = @rate.monto_min_brasil
          @barrera_1 = true
        when "Chile"
          @tasaMin = @rate.rate_chile
          @tasaOf = @rate.rate_chile_min
          @montoMin = @rate.monto_min_chile
          @barrera_1 = true
        when "Colombia"
          @tasaMin = @rate.rate_colombia
          @tasaOf = @rate.rate_colombia_min
          @montoMin = @rate.monto_min_colombia
          @barrera_1 = true
        when "Ecuador"
          @tasaMin = @rate.rate_ecuador
          @tasaOf = @rate.rate_ecuador_min
          @montoMin = @rate.monto_min_ecuador
          @barrera_1 = true
        when "España"
          @tasaMin = @rate.rate_españa
          @tasaOf = @rate.rate_españa_min
          @montoMin = @rate.monto_min_españa
          @barrera_1 = true
        when "Panama"
          @tasaMin = @rate.rate_panama
          @tasaOf = @rate.rate_panama_min
          @montoMin = @rate.monto_min_panama
          @barrera_1 = true
        when "Peru"
          @tasaMin = @rate.rate_peru
          @tasaOf = @rate.rate_peru_min
          @montoMin = @rate.monto_min_peru
          @barrera_1 = true
        when "USA"
          @tasaMin = @rate.rate_usa
          @tasaOf = @rate.rate_usa_min
          @montoMin = @rate.monto_min_usa
          @barrera_1 = true
        when "Venezuela"
          @tasaMin = @rate.rate_venezuela
          @tasaOf = @rate.rate_venezuela_min
          @montoMin = @rate.monto_min_venezuela
          @barrera_1 = true
  
      end
    end

    def formatear_tasas
      monto_oferta = @rate.monto_oferta.gsub('.','')
      monto_oferta.gsub!(',','.')
      monto_oferta = monto_oferta.to_f

      @tasaMin.gsub!('.','')
      @tasaMin.gsub!(',','.')
      @tasaMin = @tasaMin.to_f

      @tasaOf.gsub!('.','')
      @tasaOf.gsub!(',','.')
      @tasaOf = @tasaOf.to_f
      
      @montoMin.gsub!('.','')
      @montoMin.gsub!(',','.')
      @montoMin = @montoMin.to_f

      return monto_oferta
    end
    
end