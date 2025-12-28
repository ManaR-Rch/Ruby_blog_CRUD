class AddPublishedByToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :published_by, foreign_key: { to_table: :users }, null: true
  end
end
