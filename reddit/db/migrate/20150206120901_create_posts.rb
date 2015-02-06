class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false, unique: false, index: true
      t.string :body
      t.belongs_to :user, index: true
      t.belongs_to :subreddit, index: true

      t.timestamps null: false
    end
  end
end
