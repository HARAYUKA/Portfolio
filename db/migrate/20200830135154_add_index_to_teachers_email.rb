class AddIndexToTeachersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :teachers, :email, unique: true
  end
end
