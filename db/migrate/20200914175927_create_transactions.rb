class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :monto, precision: 18, scale: 3
      t.string :metodo

      t.timestamps
    end
  end
end
