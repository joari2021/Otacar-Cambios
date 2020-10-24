class ModifyTableRates < ActiveRecord::Migration[6.0]
  def change
    drop_table :rates

    create_table :rates do |t|
      t.string :country
      t.string :moneda
      t.string :monto_oferta, default: "0,00"
      t.string :rate_brasil, default: "0,00"
      t.string :rate_brasil_min, default: "0,00" 
      t.string :rate_chile, default: "0,00" 
      t.string :rate_chile_min, default: "0,00"
      t.string :rate_ecuador, default: "0,00"
      t.string :rate_ecuador_min, default: "0,00"
      t.string :rate_españa, default: "0,00"
      t.string :rate_españa_min, default: "0,00"
      t.string :rate_panama, default: "0,00"
      t.string :rate_panama_min, default: "0,00"
      t.string :rate_peru, default: "0,00"
      t.string :rate_peru_min, default: "0,00"
      t.string :rate_portugal, default: "0,00"
      t.string :rate_portugal_min, default: "0,00"
      t.string :rate_usa, default: "0,00"
      t.string :rate_usa_min, default: "0,00"
      t.string :rate_venezuela, default: "0,00"
      t.string :rate_venezuela_min, default: "0,00"

      t.timestamps
    end
  end
end
