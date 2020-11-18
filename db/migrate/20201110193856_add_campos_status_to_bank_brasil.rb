class AddCamposStatusToBankBrasil < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_brasils, :status, :string, default: "activo"
    add_column :digital_payments, :status, :string, default: "activo"
    add_column :mobile_payments, :status, :string, default: "activo"
    add_column :wallets, :status, :string, default: "activo"
    add_column :wallet_with_users, :status, :string, default: "activo"
  end
end
