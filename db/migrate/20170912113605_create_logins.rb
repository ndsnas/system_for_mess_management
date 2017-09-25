class CreateLogins < ActiveRecord::Migration[5.1]
  def up
    create_table :logins do |t|

      t.integer "s_id"
      t.string "username"
      t.string "password"

      t.timestamps
    end
  end

  def down
    drop_table :logins
  end

end
