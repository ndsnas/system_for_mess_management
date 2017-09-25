class CreateAdmins < ActiveRecord::Migration[5.1]
  def up
    create_table :admins do |t|
      t.string "admin"
      t.string "password"
      t.timestamps
  end

  end

  def down
      drop_table :admins
  end
end
