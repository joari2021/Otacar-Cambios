class RemoveColumnToBanks < ActiveRecord::Migration[6.0]
  def change
    remove_column :banks, :state, :string
    remove_column :banks, :cod_bank, :string
    remove_column :banks, :phone, :string
  end
end
