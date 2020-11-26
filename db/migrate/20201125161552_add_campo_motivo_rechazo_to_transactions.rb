class AddCampoMotivoRechazoToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :motivo_rechazo, :string
  end
end
