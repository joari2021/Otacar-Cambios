class Bank < ApplicationRecord
   belongs_to :user

   def verify_type_account
      if self.type_account != "Ahorro" && self.type_account != "Corriente"
         self.type_account = ""
      end
   end

   validates :name, :last_name, :country, :bank, length: { maximum: 12, message: " El contenido es muy largo (caracteres minimos 12)" }
    
   validates :type_account, length: { in: 6..9, message:" El minimo de caracteres para este campo es 6 y el maximo 9" }

   validates :country, :name, :last_name, :bank, :type_account, presence: {message: " Este campo no puede estar vacio"}

   validates :country, :name, :last_name, :bank, :type_account, format: { with: /\A[a-zA-Z]+\z/,
   message: " Solo se permiten letras" }
   
   validates :identidy, :number_account, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

end
