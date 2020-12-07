class AddColumnIdToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :num_id, :string, default: ""
  end
end
