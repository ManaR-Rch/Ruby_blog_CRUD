class ChangeRoleToEnumInUsers < ActiveRecord::Migration[8.1]
  def up
    # No-op: role is already a string with correct default
  end

  def down
    # No-op
  end
end
