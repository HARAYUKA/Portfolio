class AddIndexToNurseriesEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :nurseries, :email, unique: true
  end
end
