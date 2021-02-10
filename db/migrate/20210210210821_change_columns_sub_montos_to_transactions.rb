class ChangeColumnsSubMontosToTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :sub_monto_a_recibir_1, :decimal, precision: 18, scale: 2
    change_column :transactions, :sub_monto_a_recibir_2, :decimal, precision: 18, scale: 2
    change_column :transactions, :sub_monto_a_recibir_3, :decimal, precision: 18, scale: 2
  end
end
