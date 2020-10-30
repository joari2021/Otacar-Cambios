class CreateMobilePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :mobile_payments do |t|
      t.string :country
      t.string :bank
      t.string :number_phone
      t.string :document

      t.timestamps
    end
  end
end
