class AddColumnWalletNameToWallets < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :wallet_name, :string
  end
end
