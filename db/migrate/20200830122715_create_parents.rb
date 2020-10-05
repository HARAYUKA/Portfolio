class CreateParents < ActiveRecord::Migration[5.2]
  def change
    create_table :parents do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :relationship
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
