class ModifyColumnUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :wallet_with_users, :user, :string
    add_column :wallet_with_users, :usuario, :string
  end
end
