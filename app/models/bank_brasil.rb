class BankBrasil < ApplicationRecord
    belongs_to :user

    def verify_data_save
        #VALIDAR EL CAMPO BANCO#
        bancos = %w{ Bradesco Caixa Itaú Ití Nubank Santander }

        encontrado = false
        if self.bank != "Banco Do Brasil"
            bancos.each do |banco|
                if banco === self.bank
                    encontrado = true
                end
            end
        else 
            encontrado = true
        end

        if encontrado === false
            self.bank = ""
        end

        #VALIDAR CPF#
        self.cpf.gsub!('.','')
        self.cpf.gsub!('-','')
     end
  
     validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }
      
     validates :bank, presence: { message:" La opción seleccionada es invalida" }
  
     validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
     message: " Este campo no puede estar vacio y solo acepta letras" }
     
     validates :number_agency, :number_account, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}
  
     validates :number_account, length: { is: 20, message: " Este campo debe contener 20 numeros" }
     validates :number_agency, length: { is: 4, message: " Este campo debe contener 4 numeros" }
     validates :cpf, length: { is: 11, message: " Este campo debe contener 11 numeros" }
end
