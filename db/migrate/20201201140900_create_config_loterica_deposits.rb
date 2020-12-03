class CreateConfigLotericaDeposits < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_brasils, :deposit_for_loterica, :boolean, default: false
    add_column :bank_brasils, :cupos_for_loterica, :integer, default: 3

    create_table :config_loterica_deposits do |t|
      t.integer :prioridad_min_1
      t.integer :prioridad_min_2
      t.integer :prioridad_min_3
      t.integer :prioridad_max_1
      t.integer :prioridad_max_2
      t.integer :prioridad_max_3
    end
  end
end
