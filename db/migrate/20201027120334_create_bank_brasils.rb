class CreateBankBrasils < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_brasils do |t|
      t.string :name
      t.string :last_name
      t.string :country
      t.string :cpf
      t.string :bank
      t.string :number_agency
      t.string :number_account

      t.timestamps
    end
  end
end
