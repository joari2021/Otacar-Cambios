class ChangeColumnDocumentToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :document, :string
  end
end
