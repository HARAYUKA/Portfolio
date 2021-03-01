class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms do |t|
      t.string :class_name
      t.string :class_teacher
      t.timestamps
    end
  end
end
