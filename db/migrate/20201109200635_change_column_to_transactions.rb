class ChangeColumnToTransactions < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :monto, :decimal
    remove_column :transactions, :payment_bank, :integer
    remove_column :transactions, :status, :string

    add_column :transactions, :monto_envio, :string, default: "0,00"
    add_column :transactions, :monto_a_recibir, :string
    add_column :transactions, :account_origin, :integer
    add_column :transactions, :status, :string, default: "en proceso"
  end
end
