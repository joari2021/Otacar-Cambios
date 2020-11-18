class AddCampoMontoMinToRates < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :monto_min_argentina, :string, default: "0,00"
    add_column :rates, :monto_min_brasil, :string, default: "0,00"
    add_column :rates, :monto_min_chile, :string, default: "0,00"
    add_column :rates, :monto_min_colombia, :string, default: "0,00"
    add_column :rates, :monto_min_ecuador, :string, default: "0,00"
    add_column :rates, :monto_min_españa, :string, default: "0,00"
    add_column :rates, :monto_min_panama, :string, default: "0,00"
    add_column :rates, :monto_min_peru, :string, default: "0,00"
    add_column :rates, :monto_min_portugal, :string, default: "0,00"
    add_column :rates, :monto_min_usa, :string, default: "0,00"
    add_column :rates, :monto_min_venezuela, :string, default: "0,00"
  end
end
