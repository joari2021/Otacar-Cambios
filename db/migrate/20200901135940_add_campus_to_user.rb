class AddCampusToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :last_name, :string
    add_column :users, :document, :string
    add_column :users, :phone, :string
    add_column :users, :day, :integer
    add_column :users, :month, :string
    add_column :users, :year, :integer
    add_column :users, :gender, :string
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :num_user, :string
    add_column :users, :permission_level, :integer
  end
end
