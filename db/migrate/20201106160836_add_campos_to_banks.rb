class AddCamposToBanks < ActiveRecord::Migration[6.0]
  def change
    add_column :banks, :status, :string, default: "activo"
  end
end
