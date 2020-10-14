class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.string :child_name
      t.integer :age
      t.date :birthday
      t.integer :gender
      t.references :parent, foreign_key: true
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
