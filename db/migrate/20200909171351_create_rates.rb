class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.string :country
      t.string :moneda
      t.integer :monto_oferta
      t.decimal :rate_argentina, precision: 9, scale: 3
      t.decimal :rate_argentina_min, precision: 9, scale: 3
      t.decimal :rate_brasil, precision: 9, scale: 3
      t.decimal :rate_brasil_min, precision: 9, scale: 3
      t.decimal :rate_chile, precision: 9, scale: 3
      t.decimal :rate_chile_min, precision: 9, scale: 3
      t.decimal :rate_ecuador, precision: 9, scale: 3
      t.decimal :rate_ecuador_min, precision: 9, scale: 3
      t.decimal :rate_españa, precision: 9, scale: 3
      t.decimal :rate_españa_min, precision: 9, scale: 3
      t.decimal :rate_panama, precision: 9, scale: 3
      t.decimal :rate_panama_min, precision: 9, scale: 3
      t.decimal :rate_peru, precision: 9, scale: 3
      t.decimal :rate_peru_min, precision: 9, scale: 3
      t.decimal :rate_portugal, precision: 9, scale: 3
      t.decimal :rate_portugal_min, precision: 9, scale: 3
      t.decimal :rate_usa, precision: 9, scale: 3
      t.decimal :rate_usa_min, precision: 9, scale: 3
      t.decimal :rate_venezuela, precision: 9, scale: 3
      t.decimal :rate_venezuela_min, precision: 9, scale: 3

      t.timestamps
    end
  end
end
