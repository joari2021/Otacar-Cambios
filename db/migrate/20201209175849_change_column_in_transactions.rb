class ChangeColumnInTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :monto_envio, :decimal, precision: 18, scale: 2
    change_column :transactions, :monto_a_recibir, :decimal, precision: 18, scale: 2
  end
end
