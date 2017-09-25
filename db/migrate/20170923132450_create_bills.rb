class CreateBills < ActiveRecord::Migration[5.1]
  def up
    create_table :bills do |t|
      t.string "roll_no"
      t.float "amount"
      t.boolean "status"
      t.integer "month"
      t.timestamps
    end
  end
  def down
    drop_table :bills
  end
end
