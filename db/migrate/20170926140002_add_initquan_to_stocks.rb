class AddInitquanToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :initquan, :float
  end
end
