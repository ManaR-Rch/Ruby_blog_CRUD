class AddCommentsCountToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false

    # Backfill existing comments count
    Post.reset_column_information
    Post.find_each do |post|
      Post.where(id: post.id).update_all(comments_count: post.comments.count)
    end
  end
end
