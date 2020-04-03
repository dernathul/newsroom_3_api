class Api::V1::AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == "editor"
      articles = Article.where(published: false)
      render json: articles, each_serializer: ArticlesShowSerializer
    else
      render json: {
               message: 'You are not authenticated to view unpublished articles'
             },
             status: 401
    end
  end
end
