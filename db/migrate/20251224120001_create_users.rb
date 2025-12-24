class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :role, default: "member"

      t.timestamps
    end
  end
end
