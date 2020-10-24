class AddCamposToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :account_destinity, :integer, default:1
    add_column :transactions, :payment_bank, :integer, default:1
    add_column :transactions, :status, :string, default: "enviada"
  end
end
