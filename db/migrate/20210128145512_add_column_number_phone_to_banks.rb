class AddColumnNumberPhoneToBanks < ActiveRecord::Migration[6.0]
  def change
    add_column :banks, :number_phone, :string
  end
end
