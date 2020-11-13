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
      t.datetime :dinner_time
      t.string :amount_dinner
      t.datetime :morning_time
      t.string :amount_morning
      t.datetime :lunch_time
      t.string :amount_lunch
      t.datetime :first_snack
      t.string :amount_1_snack
      t.datetime :second_snack
      t.string :amount_2_snack
      t.datetime :toilet_time
      t.string :toilet_status
      t.datetime :start_night_sleep
      t.datetime :end_night_sleep
      t.datetime :start_afternoon_sleep
      t.datetime :end_afternoon_sleep
      t.string :status_at_home
      t.string :status_at_school
      t.string :info_from_home
      t.string :info_from_school
      t.references :child, foreign_key: true

      t.timestamps
    end
  end
end
