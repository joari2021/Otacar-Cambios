class MobilePayment < ApplicationRecord
    belongs_to :user

    ## Diseñar
    def verify_data_saved
        lista_bancos = ["0156","0172","0171","0166","0175","0128","0102","0114","0163","0115","0105","0191","0116","0138","0108","0104","0168","0134","0177","0174","0157","0151","0169","0137"]

        valido = false

        lista_bancos.each do |codigo|
            if codigo === self.bank
                valido = true
            end
        end

        unless valido
            self.bank = ""
        end
    end


    validates :bank, presence: {message: " La opción seleccionada es inválida"}
    validates :name, :last_name, presence: {message: " Este campo no puede estar vacio"}

    validates :number_phone, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

    validates :number_phone, length: { is: 11, message: " (caracteres maximos 11)" }
    
    validates :document, length: { in: 8..10, message: " El contenido debe contener entre 6 y 8 numeros" }
    
end
