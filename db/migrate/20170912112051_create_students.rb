class CreateStudents < ActiveRecord::Migration[5.1]
  def up
    create_table :students do |t|

      t.string "roll_no"
      t.string "name"
      t.integer "phone"
      t.string "email"

      t.timestamps
    end
  end

  def down
    drop_table :students
  end

end
