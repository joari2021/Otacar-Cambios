class CreateWalletWithUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :wallet_with_users do |t|
      t.string :country
      t.string :name
      t.string :last_name
      t.string :user
      t.string :wallet_name

      t.timestamps
    end
  end
end
