class ArticlesIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :snippet, :category, :premium
end
