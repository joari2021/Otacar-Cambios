class DigitalPayment < ApplicationRecord
    belongs_to :user

    def verify_data_saved
        case self.country
        when "Colombia"
            if self.payment_method != "Nequi"
                self.payment_method = ""
            end
        end
    end

    validates :payment_method, presence: {message: " La opción seleccionada es inválida"}

    validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }

    validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
    message: " Este campo no puede estar vacio y solo acepta letras" }

    validates :number_phone, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}
end
