class CreateSubreddits < ActiveRecord::Migration
  def change
    create_table :subreddits do |t|
      t.string :name, null: false, unique: false, index: true
      t.timestamps null: false
    end
  end
end
