class AddColumnBankToWallets < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :bank, :string
    add_column :wallets, :second_name, :string
    add_column :wallets, :type_identificador, :string, default: "Correo Electrónico"
    rename_column :wallets, :email, :identificador
    add_column :wallet_with_users, :second_name, :string
    add_column :banks, :second_name, :string
    add_column :bank_brasils, :second_name, :string
    add_column :digital_payments, :second_name, :string
    add_column :mobile_payments, :second_name, :string
    add_column :mobile_payments, :name, :string
    add_column :mobile_payments, :last_name, :string
  end
end