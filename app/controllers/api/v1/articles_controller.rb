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
      if article.persisted? && attach_image(article)
        render json: { message: 'Your article was saved' }
      else
        render json: { message: article.errors.full_messages.to_sentence },
               status: 422
      end
    else
      render json: { message: 'You are not authenticated to create an article' },
      status: 401
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :snippet, :content, :category, :premium)
  end

  def attach_image(article)
    params_image = params['article']['image']

    if params_image.present?
    DecodeService.attach_image(params_image, article.image)
    end
  end
end
