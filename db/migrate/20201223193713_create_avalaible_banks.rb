class CreateAvalaibleBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :avalaible_banks do |t|
      t.string :bank

      t.timestamps
    end
  end
end
