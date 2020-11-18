class AddCamposToRates < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :rate_argentina, :string, default: "0,00"
    add_column :rates, :rate_argentina_min, :string, default: "0,00"
    add_column :rates, :rate_colombia, :string, default: "0,00"
    add_column :rates, :rate_colombia_min, :string, default: "0,00"
  end
end
