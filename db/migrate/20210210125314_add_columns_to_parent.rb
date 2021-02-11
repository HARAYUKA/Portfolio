class AddColumnsToParent < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :uid, :string
    add_column :parents, :oauth_token, :string
    add_column :parents, :oauth_expires_at, :string
  end
end
