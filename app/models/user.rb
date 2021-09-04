class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  
  
  
  has_many :relationships, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  def self.looks(searches, words)
    if searches == "perfect_match"
      @user = User.where("name LIKE ?","#{words}")
    elsif searches == "forward_match"
      @user = User.where("name Like ?","#{words}%")
    elsif searches == "backward_match"
      @user = User.where("name Like ?","%#{words}")
    else
      @user = User.where("name LIKE ?","%#{words}%")
    end
  end

  
  attachment :profile_image
  
validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
validates :introduction, length: { maximum: 50 }
  
end



