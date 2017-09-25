class CreateMessCuts < ActiveRecord::Migration[5.1]
  def up
    create_table :mess_cuts do |t|

      t.string "roll_no"
      t.string "name"
      t.date "from"
      t.date "to"
      t.string "status"

      t.timestamps
    end
  end

  def down
    drop_table :mess_cuts
  end

end
