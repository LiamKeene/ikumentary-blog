class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :display_name
      t.string :email
      t.string :url
      t.string :login
      t.string :password
      t.string :user_type

      t.timestamps
    end
  end
end
