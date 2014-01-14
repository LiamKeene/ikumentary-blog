class RenameCommentsPostIdToArticleId < ActiveRecord::Migration
  def change
    rename_column :comments, :post_id, :article_id
  end
end
