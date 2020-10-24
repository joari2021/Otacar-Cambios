class AddCamposToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :second_name, :string
    add_column :users, :second_surname, :string
    remove_column :users, :document, :string
    add_column :users, :document, :integer
  end
end
