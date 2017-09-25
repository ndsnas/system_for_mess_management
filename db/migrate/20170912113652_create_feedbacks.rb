class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def up
    create_table :feedbacks do |t|

      t.string "s_id"
      t.string "name"
      t.string "feedback"
      t.string "status"
      t.string "type"
      t.timestamps
    end
  end

  def down
    drop_table :feedbacks
  end

end
