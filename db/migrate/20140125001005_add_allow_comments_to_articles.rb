class AddAllowCommentsToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :allow_comments, :boolean

    Article.all.each do |article| 
      article.update_attribute(:allow_comments, true)
    end
  end

  def down
    remove_column :articles, :allow_comments
  end
end
