class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :guest_id
      t.integer :event_id
      t.string :comment_content

      t.timestamps
    end
  end
end
