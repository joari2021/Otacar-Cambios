class AddColumnsToBankBrasils < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_brasils, :type_document, :string
    rename_column :bank_brasils, :cpf, :document
  end
end
