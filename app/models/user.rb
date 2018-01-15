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

  def is_admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end
end
