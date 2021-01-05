class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.integer :staff_id
      t.boolean :reply_check
      t.string :password_digest
      t.string :remember_digest
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
