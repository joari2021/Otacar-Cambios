class AddUserIdToMobilePayment < ActiveRecord::Migration[6.0]
  def change
    add_reference :mobile_payments, :user, null: false, foreign_key: true
  end
end
