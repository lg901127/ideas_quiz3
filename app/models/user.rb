class User < ActiveRecord::Base
  has_many :ideas, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea
  has_many :memberships, dependent: :destroy
  has_many :membership_ideas, through: :memberships, source: :ideas
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  has_secure_password
end
