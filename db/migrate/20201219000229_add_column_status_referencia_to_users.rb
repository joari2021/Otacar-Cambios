class AddColumnStatusReferenciaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :status_referencia, :string, default: "indefinido"
  end
end
