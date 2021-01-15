class BankBrasil < ApplicationRecord
    belongs_to :user

    def verify_data_saved
        #VALIDAR EL CAMPO BANCO#
        bancos = %w{ Bradesco Caixa Itaú Iti Nubank Santander }

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
    end
     
    def modify_cpf
        #VALIDAR CPF#
        cpf = self.cpf.tr('^0-9', '')
        
        if self.bank === "Santander"
            
            if cpf.length != 14
                self.cpf = ""
            else #FORMATEANDO CPNJ
                self.cpf = cpf.slice(0,2) + "." + cpf.slice(2,3) + "." + cpf.slice(5,3) + "/" + cpf.slice(8,4) + "-" + cpf.slice(12,2)
            end
        else
            if cpf.length != 11
                self.cpf = ""
            else #FORMATEANDO CPF
                self.cpf = cpf.slice(0,3) + "." + cpf.slice(3,3) + "." + cpf.slice(6,3) + "-" + cpf.slice(9,2)
            end
        end
        
    end
     validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }
      
     validates :bank, presence: { message:" La opción seleccionada es invalida" }
     validates :cpf, presence: { message:" El número ingresado es invalido" }
  
     validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
     message: " Este campo no puede estar vacio y solo acepta letras" }
     
     validates :number_agency, :number_account, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}
  
     validates :number_account, length: { in: 3..20, message: " Este campo debe contener 20 numeros" }
     validates :number_agency, length: { is: 4, message: " Este campo debe contener 4 numeros" }
     #validates :cpf, length: { is: 11, message: " Este campo debe contener 11 numeros" }
end
