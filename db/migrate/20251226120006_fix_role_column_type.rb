class FixRoleColumnType < ActiveRecord::Migration[8.1]
  def up
    # Change role column to string type with proper default
    change_column :users, :role, :string, default: "member"
  end

  def down
    change_column :users, :role, :string, default: nil
  end
end
