class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user
      t.belongs_to :room
      t.string :status
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
