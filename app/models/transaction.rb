class Transaction < ApplicationRecord
    belongs_to :user
    mount_uploader :comprobante_pago_otacar, ImagenTransactionUploader
    mount_uploader :comprobante_pago_usuario, ImagenTransactionUploader
    mount_uploader :comprobante_pago_usuario2, ImagenTransactionUploader
    mount_uploader :comprobante_pago_usuario3, ImagenTransactionUploader

    def verify_methods
        
        if self.country_destinity === "Venezuela"
            methods_usuario = self.account_destinity_usuario.split(",")
            methods_usuario_def = ""
            
            if methods_usuario.count >= 1
                methods_usuario.each do |method_usuario|
                    method_array = method_usuario.split("-")
                    
                    case method_array[0]

                    when "banks"
                        banco = Bank.find_by(id:method_array[1].to_i)
                        if banco.present?
                            if banco.user.id === self.user.id && banco.country === "Venezuela"
                                methods_usuario_def << method_usuario + ","
                            end
                        end
                    when "mobile_payments"
                        banco = MobilePayment.find_by(id:method_array[1].to_i)
                        if banco.present?
                            if banco.user.id === self.user.id && banco.country === "Venezuela"
                                methods_usuario_def << method_usuario + ","
                            end
                        end
                    end
                end
            elsif methods_usuario.count <= 0
                self.account_destinity_usuario = ""
            end

            if methods_usuario_def != ""
                self.account_destinity_usuario = methods_usuario_def
            else
                self.account_destinity_usuario = ""
            end
        else
            #COMPLETAR ESTA VALIDACION CONDICIONAL PARA LOS DEMAS PAISES
        end
    end

    validates :country_destinity, :account_destinity_admin, :account_destinity_usuario, presence: { message:" Este campo no puede estar vacio" }

    validates :metodo, presence: { message: " Este campo no puede estar vacio" }
    
    #validates :monto_envio, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

    def send_email
        TransactionMailer.new_transaction(self).deliver_later
    end
end