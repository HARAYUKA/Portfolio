class CreateParents < ActiveRecord::Migration[5.2]
  def change
    create_table :parents do |t|
      t.string :name
      t.string :email
      t.string :child_name
      t.string :child_class
      t.string :relationship
      t.string :class_teacher
      t.string :password_digest
      t.string :remember_digest
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
