class TransactionMailer < ApplicationMailer
    def new_transaction(transaction)
        @transaction = transaction

        users = User.all
        users.each do |user|
            if user.is_admin?
                @user_admin = user
            end
        end
            
        mail(to: "otacarcambios@gmail.com", subject: "Nueva transacción por confirmar")
    end
end
