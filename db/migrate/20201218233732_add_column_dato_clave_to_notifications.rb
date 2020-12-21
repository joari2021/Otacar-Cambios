class AddColumnDatoClaveToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :dato_clave, :string
  end
end
