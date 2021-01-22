class AddMontoARecibirTwoAndThreeToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :sub_monto_a_recibir_1, :string
    add_column :transactions, :sub_monto_a_recibir_2, :string
    add_column :transactions, :sub_monto_a_recibir_3, :string
  end
end
