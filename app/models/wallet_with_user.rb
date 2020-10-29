class WalletWithUser < ApplicationRecord
    belongs_to :user

    def verify_data_saved
        case self.country.capitalize
        when "Brasil"
            if self.wallet_name != "Pic Pay"
                self.wallet_name = ""
            end
        else
        end
    end
    
    validates :usuario, presence: {message: " Este campo no puede estar vacio"}

    validates :wallet_name, presence: {message: " La opción seleccionada es inválida"}

    validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }

    validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/, message: " Este campo no puede estar vacio y solo acepta letras" }    
end