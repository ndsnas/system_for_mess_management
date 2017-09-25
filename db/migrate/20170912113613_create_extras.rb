class CreateExtras < ActiveRecord::Migration[5.1]
  def up
    create_table :extras do |t|

      t.string "roll_no"
      t.string "name"
      t.string "item"
      t.timestamps
    end
  end

  def down
    drop_table :extras
  end

end
