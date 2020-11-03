class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.string :status_attendance
      t.datetime :attendance_time
      t.datetime :pick_up_time
      t.string :pick_up_person
      t.string :feeling
      t.float :temp
      t.time :dinner_time
      t.string :amount_dinner
      t.time :morning_time
      t.string :amount_morning
      t.time :lunch_time
      t.string :amount_lunch
      t.time :first_snack
      t.string :amount_1_snack
      t.time :second_snack
      t.string :amount_2_snack
      t.time :toilet_time
      t.string :toilet_status
      t.time :night_sleep
      t.time :afternoon_sleep
      t.string :status_at_home
      t.string :status_at_school
      t.string :info_from_home
      t.string :info_from_school
      t.references :child, foreign_key: true

      t.timestamps
    end
  end
end
