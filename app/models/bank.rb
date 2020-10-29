class Bank < ApplicationRecord
   belongs_to :user

   def verify_data_save
      if self.type_account != "Ahorro" && self.type_account != "Corriente"
         self.type_account = ""
      end

      case self.country
      when "Argentina"
         if self.bank != "Brubank" && self.bank != "Galicia"
            self.bank = ""
         end
      when "Chile"
         if self.bank != "Banco Estado"
            self.bank = ""
         end
      when "Ecuador"
         if self.bank != "Banco Pichincha"
            self.bank = ""
         end
      when "Panama"
         if self.bank != "Banco Mercantil Panama"
            self.bank = ""
         end
      when "Peru"
         if self.bank != "Banco BCP" && self.bank != "Escotia Bank"
            self.bank = ""
         end
      else
        "You gave me -- I have no idea what to do with that."
      end
   end

   validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }
    
   validates :type_account, :bank, presence: { message:" La opción seleccionada es invalida" }

   validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
   message: " Este campo no puede estar vacio y solo acepta letras" }
   
   validates :identidy, :number_account, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

   validates :number_account, length: { is: 20, message: " Este campo debe contener 20 numeros" }

end
