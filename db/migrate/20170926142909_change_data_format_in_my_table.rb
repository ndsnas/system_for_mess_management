class ChangeDataFormatInMyTable < ActiveRecord::Migration[5.1]
  def change
    change_column :students, :phone, :bigint
    
  end
end
