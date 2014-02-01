class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.integer :user_id,   null: false
      t.string  :title,     null: false, default: ""
      t.text    :content,   null: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end

    add_index :blog_posts, [:user_id, :title], unique: true
  end
end