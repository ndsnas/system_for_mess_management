class CreateMenus < ActiveRecord::Migration[5.1]
  def up
    create_table :menus do |t|
      t.string "day"
      t.string "meal1"
      t.string "meal2"
      t.string "meal3"
      t.timestamps
    end
  end

  def down
    drop_table :menus
  end
end
