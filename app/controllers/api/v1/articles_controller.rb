class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
    articles = Article.all
    render json: articles, each_serializer: ArticlesIndexSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: ArticlesShowSerializer
  end

  def create
    if current_user.role === 'journalist'
      article = Article.create(article_params)
      if article.persisted?
        render json: { message: 'Your article was saved' }
      else
        render json: { message: article.errors.full_messages.to_sentence },
               status: 422
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :snippet, :content, :category)
  end
end
