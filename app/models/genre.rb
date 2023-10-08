class Genre < ApplicationRecord
  has_many :posts
  validates :genre_name, presence: ture
end
