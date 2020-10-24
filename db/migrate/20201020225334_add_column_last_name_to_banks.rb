class AddColumnLastNameToBanks < ActiveRecord::Migration[6.0]
  def change
    add_column :banks, :last_name, :string, default: ""
  end
end
