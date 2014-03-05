class BlogComment < ActiveRecord::Base

  belongs_to :user
  belongs_to :blog_post

  validates :user_id,      presence: true
  validates :blog_post_id, presence: true
  validates :content,      presence: true, length: {minimum: 1}

end
