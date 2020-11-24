class Transaction < ApplicationRecord
    belongs_to :user
    has_one_attached :comprobante

    def modify_monto_envio
        #VALIDAR CPF#
        self.monto_envio.gsub!('.','')
        self.monto_envio.gsub!(',','.')
    end

    validates :country_destinity, :account_destinity_admin, :account_destinity_usuario, presence: { message:" Este campo no puede estar vacio" }

    validates :metodo, presence: { message: " Este campo no puede estar vacio" }
    
    #validates :monto_envio, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}
end
