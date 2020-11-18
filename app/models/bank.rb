class Bank < ApplicationRecord
   belongs_to :user

   def verify_data_saved
      if self.type_account != "Ahorro" && self.type_account != "Corriente"
         self.type_account = ""
      end

      case self.country
      when "Argentina"
         if self.banco != "Brubank" && self.banco != "Galicia"
            self.banco = ""
            self.name = ""
         end
      when "Chile"
         if self.banco != "Banco Estado"
            self.banco = ""
         end
      when "Colombia"
         if self.banco != "Bancolombia"
            self.banco = ""
         end
      when "Ecuador"
         if self.banco != "Banco Pichincha"
            self.banco = ""
         end
      when "España"
         if self.banco != "Bankia" && self.banco != "Santander"
            self.banco = ""
         end
      when "Panama"
         if self.banco != "Banco Mercantil Panama"
            self.banco = ""
         end
      when "Peru"
         if self.banco != "Banco BCP" && self.banco != "Escotia Bank"
            self.banco = ""
         end
      when "Venezuela"
         if self.banco != "Banco Mercantil" && self.banco != "B.O.D" && self.banco != "Banco De Venezuela" && self.banco != "Banco Banesco"
            self.banco = ""
         end
      end

      if self.type_document != "V" && self.type_document != "E" && self.type_document != "P" && self.type_document != "J"
         self.type_document = ""
      else
         case self.type_document
         when "V"
            unless self.identidy.length >= 6 && self.identidy.length <= 8
               self.identidy = ""
            end
         when "E"
            unless self.identidy.to_i > 80000000 && self.identidy.to_i < 100000000
               self.identidy = ""
            end
         when "P"
            unless self.identidy.length === 9
               self.identidy = ""
            end
         when "J"
            unless self.identidy.length === 9
               self.identidy = ""
            end
         end
      end
   end

   validates :name, :last_name, length: { maximum: 12, message: " El contenido es muy largo (caracteres maximos 12)" }
    
   validates :type_account, :banco, presence: { message:" La opción seleccionada es invalida" }

   validates :name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
   message: " Este campo no puede estar vacio y solo acepta letras" }
   
   validates :number_account, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

   validates :number_account, length: { is: 20, message: " Este campo debe contener 20 numeros" }

end
