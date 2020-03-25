class ArticlesShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :snippet, :content
end
