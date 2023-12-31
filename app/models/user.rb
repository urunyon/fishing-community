class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 15 }
  validates :nickname, presence: true, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: true
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
end
