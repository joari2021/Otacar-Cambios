class ChangeColumnToTransactionOfIntegerToString < ActiveRecord::Migration[6.0]
  def change
    remove_column :transactions, :account_origin, :integer
    remove_column :transactions, :account_destinity, :integer

    add_column :transactions, :account_destinity_usuario, :string
    add_column :transactions, :account_destinity_admin, :string
    add_column :transactions, :country_destinity, :string
  end
end
