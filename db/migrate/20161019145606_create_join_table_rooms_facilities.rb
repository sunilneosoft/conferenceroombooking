class CreateJoinTableRoomsFacilities < ActiveRecord::Migration
  def change
    create_join_table :rooms, :facilities do |t|
      # t.index [:room_id, :facility_id]
      # t.index [:facility_id, :room_id]
    end
  end
end
