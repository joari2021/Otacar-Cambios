class ChangeColumnMontoToTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :monto_envio, :string
    add_column :transactions, :monto_envio, :string
  end
end
