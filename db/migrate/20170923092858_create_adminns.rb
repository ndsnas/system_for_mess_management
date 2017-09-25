class CreateAdminns < ActiveRecord::Migration[5.1]
  def change
    create_table :adminns do |t|
      t.string "admin"
      t.string "password"
      t.timestamps
      t.timestamps
    end
  end

  def down
      drop_table :admins
  end
end
