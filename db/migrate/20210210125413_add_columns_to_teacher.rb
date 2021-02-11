class AddColumnsToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :uid, :string
    add_column :teachers, :oauth_token, :string
    add_column :teachers, :oauth_expires_at, :string
  end
end
