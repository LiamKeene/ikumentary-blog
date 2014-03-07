class ChangePostsPublishedAtToDatetime < ActiveRecord::Migration
  # Part 2 of 3 migrations to change the Post.status string field
  # to Post.published_at datetime field
  
  # Changes the field type from string to datetime, where the DB data
  # needs to be changed from 'Published' to the published datetime.
  # Although at this stage the data is trivial, it is good practice 
  # to handle the conversion with up/down migrations
  def up
    # Save current created_at datetimes and published_at strings
    @save_created_at = Post.all.map(&:created_at)
    @save_published_at = Post.all.map(&:published_at)

    # No point in setting column to :timestamp as Rails will make it :datetime
    # Also as the column is changing from a string field with a limit of 255 we
    # need to explicitly set the limit to nil
    change_column :posts, :published_at, :datetime, limit: nil

    # Posts that had `published_at` == 'Published' will use their `created_at`
    # value for `published_at` or else nil
    Post.reset_column_information
    Post.all.each_with_index do |post, index|
      post.update_attribute(
        :published_at,
        @save_published_at[index] == 'Published' ? @save_created_at[index] : nil
      )
    end
  end

  def down
    # Save current published_at datetimes
    @save_published_at = Post.all.map(&:published_at)

    change_column :posts, :published_at, :string

    # Posts that have a `published_at` value will become the string 'Published'
    # or else they will be nil
    Post.reset_column_information
    Post.all.each_with_index do |post, index|
      post.update_attribute(
        :published_at,
        @save_published_at[index].nil? ? nil : 'Published'
      )
    end
  end
end
