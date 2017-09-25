class AddDateToExtra < ActiveRecord::Migration[5.1]
  def change
    add_column :extras, :date, :date
  end
end
