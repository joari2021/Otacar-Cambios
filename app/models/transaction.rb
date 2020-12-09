class Transaction < ApplicationRecord
    belongs_to :user
    mount_uploader :comprobante_pago_otacar, ImagenTransactionUploader
    mount_uploader :comprobante_pago_usuario, ImagenTransactionUploader

    validates :country_destinity, :account_destinity_admin, :account_destinity_usuario, presence: { message:" Este campo no puede estar vacio" }

    validates :metodo, presence: { message: " Este campo no puede estar vacio" }
    
    #validates :monto_envio, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

    def send_email
        TransactionMailer.new_transaction(self).deliver_later
    end
end