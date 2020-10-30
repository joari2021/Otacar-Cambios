class ModifyColumnToBank < ActiveRecord::Migration[6.0]
  def change
    remove_column :banks, :bank, :string
    add_column :banks, :banco, :string
  end
end
