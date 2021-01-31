class AddColumnStatusEnvioToRates < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :status_envio, :boolean, default: false
  end
end
