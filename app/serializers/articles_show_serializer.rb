class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :snippet, :content, :category, :premium
end
