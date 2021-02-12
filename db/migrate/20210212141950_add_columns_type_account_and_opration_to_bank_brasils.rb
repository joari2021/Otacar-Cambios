class AddColumnsTypeAccountAndOprationToBankBrasils < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_brasils, :type_account, :string, default: "Sin Definir"
    add_column :bank_brasils, :operation, :string, default: "Sin Definir"
  end
end
