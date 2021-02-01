class RemoveColumnsToMethodsPayments < ActiveRecord::Migration[6.0]
  def change
    remove_column :banks, :transactions_in_process, :integer
    remove_column :banks, :permit_delete, :string

    remove_column :bank_brasils, :transactions_in_process, :integer
    remove_column :bank_brasils, :permit_delete, :string

    remove_column :mobile_payments, :transactions_in_process, :integer
    remove_column :mobile_payments, :permit_delete, :string

    remove_column :digital_payments, :transactions_in_process, :integer
    remove_column :digital_payments, :permit_delete, :string

    remove_column :wallets, :transactions_in_process, :integer
    remove_column :wallets, :permit_delete, :string

    remove_column :wallet_with_users, :transactions_in_process, :integer
    remove_column :wallet_with_users, :permit_delete, :string
  end
end
