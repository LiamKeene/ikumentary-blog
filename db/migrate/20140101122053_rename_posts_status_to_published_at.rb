class RenamePostsStatusToPublishedAt < ActiveRecord::Migration
  # Part 1 of 3 migrations to change the Post.status string field
  # to Post.published_at datetime field
  def change
    rename_column :posts, :status, :published_at
  end
end
