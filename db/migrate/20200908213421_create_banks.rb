class CreateBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :identidy
      t.string :country
      t.string :state
      t.string :bank
      t.string :number_account
      t.string :type_account
      t.string :cod_bank
      t.string :phone

      t.timestamps
    end
  end
end
