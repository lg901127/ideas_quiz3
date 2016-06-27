class Idea < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :memberships, dependent: :destroy
  has_many :membership_users, through: :members, source: :user
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  mount_uploader :avatar, AvatarUploader

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by_user_id user
  end

  def joined_by?(user)
    memberships.exists?(user: user)
  end

  def join_for(user)
    memberships.find_by_user_id user
  end
end
