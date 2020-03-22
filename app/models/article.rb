class Article < ApplicationRecord
  validates_presence_of :title, :snippet, :content
end
