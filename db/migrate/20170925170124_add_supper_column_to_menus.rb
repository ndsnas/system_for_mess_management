class AddSupperColumnToMenus < ActiveRecord::Migration[5.1]
  def change
    add_column :menus, :supper, :string
  end
end
