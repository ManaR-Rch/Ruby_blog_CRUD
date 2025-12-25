class ChangeRoleToEnumInUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :role, :role_old

    add_column :users, :role, :integer, default: 0, null: false

    User.reset_column_information
    User.where(role_old: "admin").update_all(role: 1)
    User.where(role_old: "member").update_all(role: 0)

    remove_column :users, :role_old
  end
end
