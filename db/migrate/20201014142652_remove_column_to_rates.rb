class RemoveColumnToRates < ActiveRecord::Migration[6.0]
  def change
    remove_column :rates, :rate_argentina, :decimal, precision: 9, scale: 2, default: 0
    remove_column :rates, :rate_argentina_min, :decimal, precision: 9, scale: 2, default: 0
    
  end
end
