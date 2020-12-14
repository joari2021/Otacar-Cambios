class CreateTableNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :emisor
      t.string :content
      t.string :asunto
      t.boolean :view, default:false

      t.timestamps
    end
  end
end
