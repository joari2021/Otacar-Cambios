class ChangeColumnInTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :monto_envio, :string
    remove_column :transactions, :monto_a_recibir, :string

    add_column :transactions, :monto_envio, :decimal, precision: 18, scale: 2
    add_column :transactions, :monto_a_recibir, :decimal, precision: 18, scale: 2
  end
end
