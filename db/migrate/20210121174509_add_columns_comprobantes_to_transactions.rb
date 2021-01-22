class AddColumnsComprobantesToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :comprobante_pago_usuario2, :string
    add_column :transactions, :comprobante_pago_usuario3, :string
  end
end
