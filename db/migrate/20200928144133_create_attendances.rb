class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.string :feeling
      t.string :toilet
      t.string :meal
      t.datetime :pick_up_time
      t.string :pick_up_person
      t.float :temp
      t.time :sleep
      t.string :note
      t.references :child, foreign_key: true

      t.timestamps
    end
  end
end
