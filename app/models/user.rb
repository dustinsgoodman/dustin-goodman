class User < ActiveRecord::Base
  include TokenAuthenticatable

  has_many :blog_posts
  has_many :blog_comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { minimum: 1 }
  validates :last_name,  presence: true, length: { minimum: 1 }
end
