class AddColumnImagenToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :comprobante_pago_otacar, :string
    add_column :transactions, :comprobante_pago_usuario, :string
  end
end
