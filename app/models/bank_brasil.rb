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
     
    def modify_document
        #VALIDAR DOCUMENT#
        document = self.document.tr('^0-9', '')
        
        if self.type_document === "CPNJ"
            
            if document.length != 14
                self.document = ""
            else #FORMATEANDO CPNJ
                self.document = document.slice(0,2) + "." + document.slice(2,3) + "." + document.slice(5,3) + "/" + document.slice(8,4) + "-" + document.slice(12,2)
            end
        elsif self.type_document === "CPF"
            if document.length != 11
                self.document = ""
            else #FORMATEANDO DOCUMENT
                self.document = document.slice(0,3) + "." + document.slice(3,3) + "." + document.slice(6,3) + "-" + document.slice(9,2)
            end
        else
            self.document = ""
        end
        
    end
     validates :name, :last_name, :second_name, length: { maximum: 15, message: " (caracteres maximos 15)" }
      
     validates :bank, :type_account, presence: { message:" La opción seleccionada es invalida" }
     validates :document, presence: { message:" El número ingresado es invalido" }
  
     validates :name, :last_name, presence: { message:" Este campo no puede estar vacio" }
     
     validates :number_agency, :number_account, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}
  
     validates :number_account, length: { in: 3..20, message: " Este campo debe contener 20 numeros" }
     validates :number_agency, length: { is: 4, message: " Este campo debe contener 4 numeros" }
end
