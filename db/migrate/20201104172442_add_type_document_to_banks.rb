class AddTypeDocumentToBanks < ActiveRecord::Migration[6.0]
  def change
    add_column :banks, :type_document, :string
  end
end
