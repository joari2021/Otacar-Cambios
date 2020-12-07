class TransactionMailer < ApplicationMailer
    def new_transaction(transaction)
        @transaction = transaction

        mail(to: "jorge.uchija2021@gmail.com", subject: "Nueva transacción por confirmar")
    end
end
