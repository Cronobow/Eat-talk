class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  mount_uploader :avatar, AvatarUploader
  has_many :comments
  has_many :restaurants, through: :comments
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  has_many :friendships, dependent: :destroy
  has_many :friendings, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friending_id"
  has_many :friends, through: :inverse_friendships, source: :user

  def is_admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end

  def is_friending?(user)
    self.friendings.include?(user)
  end
end
