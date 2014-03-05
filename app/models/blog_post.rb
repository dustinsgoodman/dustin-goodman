class BlogPost < ActiveRecord::Base

  belongs_to :user
  has_many   :blog_comments

  validates :user_id, presence: true
  validates :title,   presence: true, length: {minimum: 1}
  validates :content, presence: true, length: {minimum: 1}

end
