class AddCampoPermitDeleteToBanks < ActiveRecord::Migration[6.0]
  def change
    add_column :banks, :permit_delete, :string, :default => "permit"
    add_column :bank_brasils, :permit_delete, :string, :default => "permit"
    add_column :digital_payments, :permit_delete, :string, :default => "permit"
    add_column :mobile_payments, :permit_delete, :string, :default => "permit"
    add_column :wallets, :permit_delete, :string, :default => "permit"
    add_column :wallet_with_users, :permit_delete, :string, :default => "permit"

    add_column :banks, :view, :boolean, :default => true
    add_column :bank_brasils, :view, :boolean, :default => true
    add_column :digital_payments, :view, :boolean, :default => true
    add_column :mobile_payments, :view, :boolean, :default => true
    add_column :wallets, :view, :boolean, :default => true
    add_column :wallet_with_users, :view, :boolean, :default => true

    add_column :banks, :transactions_in_process, :integer, :default => 0
    add_column :bank_brasils, :transactions_in_process, :integer, :default => 0
    add_column :digital_payments, :transactions_in_process, :integer, :default => 0
    add_column :mobile_payments, :transactions_in_process, :integer, :default => 0
    add_column :wallets, :transactions_in_process, :integer, :default => 0
    add_column :wallet_with_users, :transactions_in_process, :integer, :default => 0
  end
end
