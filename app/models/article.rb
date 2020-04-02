class Article < ApplicationRecord
  has_one_attached :image
  validates_presence_of :title, :snippet, :content, :category
  enum category: [:latest_news, :tech, :sports, :politics, :culture]
end
