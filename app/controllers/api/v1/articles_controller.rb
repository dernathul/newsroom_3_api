class Api::V1::ArticlesController < ApplicationController
  
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end
  
  def create
    article = Article.create(article_params)
    if article.persisted? 
      render json: { message: 'Your article was saved' }
    else 
      render json: { message: article.errors.full_messages.to_sentence}, status: 422
    end
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :snippet, :content)
  end
end