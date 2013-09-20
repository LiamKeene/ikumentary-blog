class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.integer :author_id
      t.string :status

      t.timestamps
    end
  end
end
