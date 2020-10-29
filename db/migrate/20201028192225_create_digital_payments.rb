class CreateDigitalPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :digital_payments do |t|
      t.string :country
      t.string :name
      t.string :last_name
      t.string :number_phone
      t.string :payment_method

      t.timestamps
    end
  end
end
