class AddAdminToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :admin, :boolean, default: false
  end
end
