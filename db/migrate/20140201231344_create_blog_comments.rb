class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer :user_id,      null: false
      t.integer :blog_post_id, null: false
      t.text    :content,      null: false

      t.timestamps
    end
  end
end
