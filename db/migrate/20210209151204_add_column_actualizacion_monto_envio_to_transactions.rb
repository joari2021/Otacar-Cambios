class AddColumnActualizacionMontoEnvioToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :actualizacion_monto_envio, :boolean, default: false
    add_column :transactions, :new_monto_a_recibir, :decimal, precision: 18, scale: 2
    add_column :transactions, :new_sub_monto_a_recibir_1, :decimal, precision: 18, scale: 2
    add_column :transactions, :new_sub_monto_a_recibir_2, :decimal, precision: 18, scale: 2
    add_column :transactions, :new_sub_monto_a_recibir_3, :decimal, precision: 18, scale: 2
  end
end
