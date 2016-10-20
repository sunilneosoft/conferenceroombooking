class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :title
      t.text :desctription

      t.timestamps null: false
    end
  end
end
