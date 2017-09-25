class CreateStocks < ActiveRecord::Migration[5.1]
  def up
    create_table :stocks do |t|
      t.string "stock_id"
      t.string "stock_name"
      t.float "quantity"
      t.float "cost_per_unit"
      t.timestamps
    end
  end

  def down
    drop_table :stocks
  end

end
