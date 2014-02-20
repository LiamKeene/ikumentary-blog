class AddExtractToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :extract, :text
  end
end
