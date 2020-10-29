class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || " Es invalido")
        end
    end
end

class Wallet < ApplicationRecord
    belongs_to :user

    def verify_data_saved
        case self.country
        when "Brasil"
            if self.wallet_name != "Pix"
                self.wallet_name = ""
            end
        when "USA"
            if self.wallet_name != "Zelle"
                self.wallet_name = ""
            end
        else
        end
    end
    
    validates :email, presence: true, email: true

    validates :wallet_name, presence: {message: " La opción seleccionada es inválida"}

    validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }

    validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
    message: " Este campo no puede estar vacio y solo acepta letras" }
end
