class CreateItems < ActiveRecord::Migration[5.1]
  def up
    create_table :items do |t|

      t.integer "item_id"
      t.string "item_name"
      t.integer "price"

      t.timestamps
    end
  end

  def down
    drop_table :items
  end

end
