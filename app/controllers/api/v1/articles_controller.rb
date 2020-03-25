class Api::V1::ArticlesController < ApplicationController
  
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def create
    article = Article.create(article_params)
    binding.pry
    if article.persisted? 
      render json: { message: 'Your article was saved' }
    else 
      render json: { error: article.errors.full_messages.to_sentence}, status: 422
    end
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :snippet, :content)
  end
end