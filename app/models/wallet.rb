class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || " Es invalido")
        end
    end
end

class Wallet < ApplicationRecord
    validates :email, presence: true, email: true

    validates :name, :last_name, :country, length: { maximum: 12, message: " El contenido es muy largo (caracteres minimos 12)" }

    validates :country, :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
    message: " Solo se permiten letras" }
end
