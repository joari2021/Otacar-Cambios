class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :country

      t.timestamps
    end
  end
end
