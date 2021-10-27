class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :host_id
      t.integer :genre_id
      t.string :title
      t.text :introduction
      t.string :image_id
      t.string :particpant
      t.integer :prefecture
      t.string :address
      t.string :date_and_time
      t.integer :holding_flag

      t.timestamps
    end
  end
end
