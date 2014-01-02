class AddIndexToPostsPublishedAt < ActiveRecord::Migration
  # Part 3 of 3 migrations to change the Post.status string field
  # to Post.published_at datetime field
  def change
    add_index :posts, :published_at
  end
end
