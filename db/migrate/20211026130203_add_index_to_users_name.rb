class AddIndexToUsersName < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :name, nil
    add_index :users, :name, unique: true
  end
end
