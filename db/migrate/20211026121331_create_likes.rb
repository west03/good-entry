class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :guest_id
      t.integer :event_id

      t.timestamps
    end
  end
end
