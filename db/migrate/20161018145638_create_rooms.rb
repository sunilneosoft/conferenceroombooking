class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.string :room_no
      t.string :type
      t.string :status

      t.timestamps null: false
    end
  end
end
