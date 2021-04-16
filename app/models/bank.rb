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
            if self.banco != "Banco BCP" && self.banco != "Scotiabank"
               self.banco = ""
            end
         when "Venezuela"
            valido = false
            if self.banco === "Banco Mercantil" || self.banco === "B.O.D" || self.banco === "Banco De Venezuela" || self.banco === "Banco Banesco"
               valido = true
            end

            lista_bancos = ["0156","0172","0171","0175","0128","0114","0163","0115","0191","0138","0108","0104","0168","0177","0174","0157","0151","0169","0137"]

            lista_bancos.each do |codigo|
               if codigo === self.banco
                  valido = true
                  break;
               end
            end

            unless valido
               self.banco = ""
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
   end

   validates :name, :last_name, :identidy, length: { maximum: 15, message: " (caracteres maximos 12)" }

   validates :name, :last_name, presence: { message:" Este campo no puede estar vacio" }
    
   validates :type_account, :banco, presence: { message:" La opción seleccionada es invalida" }
   
   validates :number_account, :identidy, format: {with: /\A[+-]?\d+\z/, message: " Este campo no puede estar vacio y solo acepta números"}

   validates :number_account, length: { in: 10..20, message: " El numero de cuenta es invalido" }

end
