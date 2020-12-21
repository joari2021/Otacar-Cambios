class RenameToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :num_user, :num_referidor
  end
end
