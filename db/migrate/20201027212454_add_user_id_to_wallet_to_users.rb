class AddUserIdToWalletToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :wallet_with_users, :user, null: false, foreign_key: true
  end
end
